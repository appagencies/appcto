class AfterRegisterController < ApplicationController
  include Wicked::Wizard
  before_filter :authenticate_user!

  steps :add_company, :successful

  def show
    case step
    when :add_company
      @company = current_user.build_company(:email => current_user.email, :website => ("http://" + current_user.email.split("@").last))
      @company.build_location
    end

    render_wizard
  end

  def update
    @company = current_user.create_company(params[:company])
    render_wizard @company
  end

  def finish_wizard_path
    company_path(current_user.company)
  end
end