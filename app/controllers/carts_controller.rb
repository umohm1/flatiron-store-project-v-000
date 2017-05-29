class CartsController < ApplicationController

  def show
    @cart = Cart.find_by(params[:id])
 end

 def checkout
    cart = Cart.find_by(params[:id])
    cart.checkout
    redirect_to cart_path(cart)
  end

end
