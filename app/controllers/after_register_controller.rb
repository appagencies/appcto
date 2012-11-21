class AfterRegisterController < ApplicationController
  include Wicked::Wizard
  before_filter :authenticate_user!

  layout 'auth'

  steps :add_company, :add_apps, :upgrade, :successful

  def show
    @user = current_user
    case step
    when :add_company
      @company = @user.company || @user.build_company(:email => @user.email, :website => ("http://" + @user.email.split("@").last), :platform => %w[ios android blackberry windows])
    when :add_apps
      @company = @user.company
      @apps = @company.apps.all
      @app = @user.company.apps.build
      @app.screenshots.build
    when :upgrade
      @company = @user.company
      @apps = @company.apps

    when :successful
      UserMailer.signup_confirmation(current_user).deliver
    end
    render_wizard
  end

  def update
    @user = current_user
    case step
    when :add_company
      @company = @user.create_company(params[:company])
      render_wizard @company

    when :add_apps
      @app = @user.company.apps.create(params[:app])
      render_wizard @app
    when :upgrade
    end
  end

  def finish_wizard_path
    company_path(current_user.company)
  end
end