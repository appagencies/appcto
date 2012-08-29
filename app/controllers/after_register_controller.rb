class AfterRegisterController < Wicked::WizardController
  before_filter :authenticate_user!

  steps :add_company

  def show
  	@company = current_user.build_company
    @company.build_location

  	render_wizard
  end

  def update
  	@company = current_user.create_company(params[:company])
  	render_wizard @company
  end
end