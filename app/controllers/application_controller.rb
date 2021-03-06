class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :all_categories
  helper_method :total_amount
  
  def all_categories
    Category.all  
  end
  
  def total_amount
    products = current_user.cart.carts_products      
    total = 0
    products.each do |product|
      total += (Product.find(product.product_id).price.to_i) * (product.quantity.to_i)  
    end
    return total
  end


  def category
    @category  = Category.find(params[:category_id])
  end


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :is_female, :dob, :mobile])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :dob, :mobile])  
  end
end