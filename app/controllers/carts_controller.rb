class CartsController < ApplicationController

  def show
    @cart = Cart.find(params[:id])
  end

  def checkout
    @cart = Cart.find_by(id: params[:id])
    @cart.cart_checkout
    @cart.user.current_cart = nil
    @cart.user.save
    redirect_to cart_path(@cart)
  end
end
