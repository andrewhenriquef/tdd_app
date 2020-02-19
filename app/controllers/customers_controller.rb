class CustomersController < ApplicationController
  before_action :set_customer, only: [:edit, :update, :show]

  def index
    @customers = Customer.all
  end

  def show; end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to @customer, notice: 'Client succesfully registered'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to @customer, notice: 'Client succesfully updated'
    else
      render :edit
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(
      :id,
      :name,
      :email,
      :phone,
      :avatar,
      :smoker
    )
  end
end
