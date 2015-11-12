class Public::CompaniesController < Public::BaseController
  before_action :set_company, only: [:edit, :update, :show]

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

  end

  private

  def company_params
    params.fetch(:company).permit :id, :name
  end

  def set_company
    begin
      @company = Company.find params[:id]
    rescue
      redirect_to public_companies_path
    end
  end

  def handle_form(on_invalid_object)
    if @company.valid?
      @company.id ? @company.update(company_params) : @company.save
      redirect_to public_company_path @company
    else
      on_invalid_object.call
    end
  end
end