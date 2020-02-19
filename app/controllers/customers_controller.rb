class CustomersController < ApplicationController
  def index; end
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
