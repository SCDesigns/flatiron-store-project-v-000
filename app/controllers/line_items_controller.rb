class LineItemsController < ApplicationController
  def create
    if current_cart.nil?
      current_user.current_cart = Cart.create
      LineItem.create(
        item_id: params[:item_id],
        cart_id: current_user.current_cart.id
        )
    else
      current_cart.add_item(params[:item_id]).save
    end
    redirect_to current_cart
  end

end
