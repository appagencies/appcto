class AppsController < ApplicationController
  load_and_authorize_resource :company
  load_and_authorize_resource :app, :through => :company

  def index
    company = Company.find params[:company_id]
    @apps = company.apps.all

    @app = company.apps.build
    @app.screenshots.build

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def show
    company = Company.find params[:company_id]
    @app = company.apps.find params[:id]

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def new
    company = Company.find params[:company_id]
    @app = company.apps.build
    @app.screenshots.build

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def create
    company = Company.find params[:company_id]
    @app = company.apps.create params[:app]

    respond_to do |format|
      if @app.save
        format.html { redirect_to(company_apps_path(company), :notice => 'App was succesfully created.')}
      else
        format.html { render :action => "new" }
      end
    end

  end

  def edit
    company = Company.find params[:company_id]
    @app = company.apps.find params[:id]
    @app.screenshots.build
  end

  def update
    company = Company.find params[:company_id]
    @app = company.apps.find params[:id]

    respond_to do |format|
      if @app.update_attributes(params[:app])
        format.html { redirect_to(company_apps_path(company), notice: 'Company was successfully updated.')}
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    company = Company.find params[:company_id]
    @app = company.apps.find params[:id]
    @app.destroy

    respond_to do |format|
      format.html { redirect_to company_apps_url }
    end
  end
end
