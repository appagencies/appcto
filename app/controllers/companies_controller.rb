class CompaniesController < ApplicationController

  def index
    @platform = params[:platform] ||= []

    @companies = Company.filter(params).shuffle.sort_by(&:size).reverse
    @companies = Kaminari.paginate_array(@companies).page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  def show
    @company = Company.find params[:id]
    @apps = @company.apps.all

    authorize! :read, @company

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
    end
  end

  def new
    @company = Company.new(:budget => 0)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company }
    end
  end

  def edit
    @company = Company.find params[:id]

    authorize! :edit, @company
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
