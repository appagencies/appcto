class CompaniesController < ApplicationController
  def subregion_options
    render partial: "subregion_select"
  end

  def index
    country = params[:country]
    region = params[:region]

    budget = params[:budget]


    if country
      @companies = Company.by_country(country)
      if region
        @companies = @companies.by_region(region)
      end
    else
      @companies = Company.is_approved.all
    end

    @companies = budget.blank? ? @companies : @companies.where("budget" => budget)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @companies }
    end
  end

  def show
    @company = Company.find params[:id]
    authorize! :read, @company

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
    @company = Company.find params[:id]
    authorize! :edit, @company
  end

  def loc
    respond_to :json
  end

  def update
    @company = Company.find params[:id]
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
    @company = Company.find params[:id]
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :no_content }
    end
  end
end
