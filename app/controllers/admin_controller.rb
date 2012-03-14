class AdminController < ApplicationController
  def index
    @cart = current_cart
    @total_orders = Order.count
  end
end
