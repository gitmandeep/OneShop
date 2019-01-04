class CartsController < ApplicationController
 
  before_action :check_cart_available, only: [:add_to_cart]
  before_action :find_cart_product, only: [:reduce_quantity, :increase_quantity, :remove_item_from_cart]

  def add_to_cart
    cp = CartsProduct.find_or_initialize_by(product_id: params[:product_id], cart_id: current_user.cart.id)
    cp.update(quantity: cp.quantity + 1)
    redirect_to cart_path(current_user.cart)
  end
  
  def show
    @cart = current_user.cart
  end
  
  def reduce_quantity
    @cart_product.update(quantity: @cart_product.quantity - 1)
    if @cart_product.quantity > 0
      redirect_to cart_path(current_user.cart)
    else
      remove_item_from_cart
    end
  end

  def increase_quantity 
    @cart_product.update(quantity: @cart_product.quantity + 1)
    redirect_to cart_path(current_user.cart)
  end 

  def remove_item_from_cart
   @cart_product.destroy
   redirect_to cart_path(current_user.cart)
  end   

  private
  def check_cart_available
    current_user.create_cart unless current_user.cart
  end

  def find_cart_product
    @cart_product = CartsProduct.find_by(product_id: params[:product_id], cart_id: current_user.cart.id)
  end
end