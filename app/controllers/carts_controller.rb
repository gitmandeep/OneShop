class CartsController < ApplicationController
 
  before_action :check_cart_available, only: [:add_to_cart]
  before_action :find_cart_product, only: [:iterate_quantity, :remove_item_from_cart]

  def add_to_cart
    cp = CartsProduct.find_or_initialize_by(product_id: params[:product_id], cart_id: current_user.cart.id)
    cp.update(quantity: cp.quantity + 1)
    @product = Product.find(params[:product_id])
    @product.number_of_units = @product.number_of_units - 1
    @product.save
    @remaining = @product.number_of_units 
    redirect_to cart_path(current_user.cart)
  end
  
  def show
    @remaining = Product.find_or_initialize_by(params[:product_id]).number_of_units
    @cart = current_user.cart
    @user = current_user
  end
  
  def iterate_quantity
      @product = Product.find(params[:product_id])
    if params[:reduce]
      @cart_product.update(quantity: @cart_product.quantity - 1)
      @product.number_of_units = @product.number_of_units + 1
      @product.save
      @remaining = @product.number_of_units
      # binding.pry
        unless @cart_product.quantity > 0
          @cart_object_removed = true if @cart_product.destroy
        end
    else
      @cart_product.update(quantity: @cart_product.quantity + 1)
      @product.number_of_units = @product.number_of_units - 1
      @product.save
      @remaining = @product.number_of_units
      # binding.pry
    end
  end

  def remove_item_from_cart
    cp = CartsProduct.find_or_initialize_by(product_id: params[:product_id], cart_id: current_user.cart.id)
    @product = Product.find(params[:product_id])
    @product.number_of_units = @product.number_of_units + cp.quantity
    @product.save
    @p_id = @cart_product.product.id
    @cart_product.destroy
    #redirect_to cart_path(current_user.cart)
  end   

  private
  def check_cart_available
    current_user.create_cart unless current_user.cart
  end

  def find_cart_product
    @cart_product = CartsProduct.find_by(product_id: params[:product_id], cart_id: current_user.cart.id)
  end
end