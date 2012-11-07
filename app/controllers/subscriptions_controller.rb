class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!

  def new
    @subscription = current_user.build_subscription
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
    @subscription = Subscription.find params[:id]
  end

  def paypal_checkout
    subscription = current_user.build_subscription
    redirect_to subscription.paypal.checkout_url(
      return_url: new_subscription_url,
      cancel_url: new_subscription_url
    )
  end

  def destroy
    @subscription = Subscription.find params[:id]
    @subscription.paypal.cancel
    @subscription.destroy

    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :no_content }
    end
  end
end