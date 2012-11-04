class Subscription
  include Mongoid::Document

  field :user_id
  field :paypal_customer_token
  field :paypal_recurring_profile_token

  attr_accessible :paypal_customer_token, :paypal_recurring_profile_token, :paypal_payment_token
  attr_accessor :paypal_payment_token

  belongs_to :user

  def save_with_payment
    if valid?
      response = paypal.make_recurring
      self.paypal_recurring_profile_token = response.profile_id
      save!
    end
  end

  def paypal
    PaypalPayment.new(self)
  end

  def payment_provided?
    paypal_payment_token.present?
  end
end
