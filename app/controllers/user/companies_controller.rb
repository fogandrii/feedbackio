class User::CompaniesController < User::BaseController
  before_action :set_company, only: [:edit, :update, :show, :destroy]

  def index
    @companies = Company.all
  end

  def show
  end

  def new
    @company = Company.new
  end

  def create
    @company = Company.new company_params
    handle_form -> { render :new }
  end

  def edit

  end

  def update
    handle_form -> { render :edit }
  end

  def destroy
    @company.delete
    flash[:notice] = "Company #{@company.name} removed"
    redirect_to user_companies_path
  end

  private

  def company_params
    params.fetch(:company).permit :id, :name
  end

  def set_company
    begin
      @company = Company.find params[:id]
    rescue
      flash[:alert] = 'Company not found'
      redirect_to user_companies_path
    end
  end

  def handle_form(on_invalid_object)
    if @company.valid?
      @company.id ? @company.update(company_params) : @company.save
      redirect_to user_company_path @company
    else
      on_invalid_object.call
    end
  end
end