class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
    flash[:mixpanel_record] = "'Created Account'"
  end

  def update
    super
  end

  protected
    def after_sign_up_path_for(resource)
      after_register_path(:add_company)
    end
end
