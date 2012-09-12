class AppsController < ApplicationController
  def index
    @company = Company.find_by_slug params[:company_id]

    @apps = @company.apps.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @apps }
    end
  end

  def show
    @company = current_user.company
    @app = @company.apps.find params[:id]

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
    end
  end

  def new
    @company = Company.new(:budget => 0)
    @company.build_location

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company }
    end
  end

  def edit
    @company = Company.find_by_slug params[:id]
    authorize! :edit, @company
  end

  def update
    @company = Company.find_by_slug params[:id]
    params[:company][:skills] ||= []

    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @company = Company.find_by_slug params[:id]
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :no_content }
    end
  end
end
