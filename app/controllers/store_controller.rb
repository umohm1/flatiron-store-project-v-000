class StoreController < ApplicationController

  def index
    @categories = Category.all
    @items = Item.all
    @cart = current_user.current_cart if current_user
  end

end
