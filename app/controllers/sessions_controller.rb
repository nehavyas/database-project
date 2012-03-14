class SessionsController < ApplicationController
  skip_before_filter :authorize
  def new
    if session[:cart_id]
      @cart = current_cart
      @cart.destroy
    end
    @cart = current_cart
  end

  def create
    @cart = current_cart
    if employee = Employee.authenticate(params[ :name], params[:password])
      session[:employee_id] = employee.id
      redirect_to admin_url
    else
      redirect_to login_url, :alert => "Invalid user /password combination"
    end
  end

  def destroy
    session[:employee_id] = nil
    redirect_to store_url, :notice => "Logged out"
  end
end
