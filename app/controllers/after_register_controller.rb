class AfterRegisterController < ApplicationController
  include Wicked::Wizard
  before_filter :authenticate_user!

  steps :add_company, :add_apps, :successful

  def show
    @user = current_user
    case step
    when :add_company
      @company = @user.build_company(:email => current_user.email, :website => ("http://" + current_user.email.split("@").last), :platform => ["ios","android","blackberry","windows"])
    when :add_apps
      @app = @user.company.apps.build
    end

    render_wizard
  end

  def update
    @user = current_user
    case step
    when :add_company
      @company = @user.create_company(params[:company])
      flash[:mixpanel_record] = "'Created Company'"
      render_wizard @company
    when :add_apps
      @app = @user.company.apps.create!(params[:app])
      flash[:mixpanel_record] = "'Created App'"
      render_wizard @app
    end

  end

  def finish_wizard_path
    company_path(current_user.company)
  end
end