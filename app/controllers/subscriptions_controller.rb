class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!, :except => [:notify]
  protect_from_forgery :except => [:notify]

  def notify
    txn_type = params[:txn_type]
    case txn_type
    when 'recurring_payment_profile_cancel', 'recurring_payment_failed', 'recurring_payment_expired'
      @subscription = Subscription.find_by(paypal_customer_token: params[:payer_id])
      @subscription.destroy
    end

    render :nothing => true
  end

  def new
    @subscription = current_user.build_subscription
    @company = current_user.company
    @apps = @company.apps
    if params[:PayerID]
      @subscription.paypal_customer_token = params[:PayerID]
      @subscription.paypal_payment_token = params[:token]
    end
  end

  def create
    @subscription = current_user.create_subscription(params[:subscription])
    if @subscription.save_with_payment
      redirect_to @subscription, :notice => "Thank you for subscribing!"
    else
      render :new
    end
  end

  def show
    @subscription = current_user.subscription
  end

  def paypal_checkout
    subscription = current_user.build_subscription
    redirect_to subscription.paypal.checkout_url(
      return_url: new_subscription_url,
      cancel_url: new_subscription_url
    )
  end

  def destroy
    @subscription = current_user.subscription
    if @subscription.destroy_with_payment
      redirect_to new_subscription_path, :notice => "We're sorry to see you go!"
    else
      render :show
    end
  end
end