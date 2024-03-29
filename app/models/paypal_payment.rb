class PaypalPayment
  def initialize(subscription)
    @subscription = subscription
  end

  def checkout_details
    process :checkout_details
  end

  def checkout_url(options)
    process(:checkout, options).checkout_url
  end

  def make_recurring
    process :request_payment
    process :create_recurring_profile, period: :monthly, frequency: 1, start_at: Time.zone.now+1.days, outstanding: :next_billing
  end

  def cancel
    process :cancel, profile_id: @subscription.paypal_recurring_profile_token
  end

private

  def process(action, options = {})
    options = options.reverse_merge(
      token: @subscription.paypal_payment_token,
      payer_id: @subscription.paypal_customer_token,
      description: "Pro - Subscription",
      amount: "99.00",
      currency: "USD",
      ipn_url: 'http://5476.localtunnel.com/paypal/notify'
    )
    response = PayPal::Recurring.new(options).send(action)
    raise response.errors.inspect if response.errors.present?
    response
  end

end