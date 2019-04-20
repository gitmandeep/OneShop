class UsersController < ApplicationController
	

  def index
    @users = User.all
  end 

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       # redirect_to @
    else
      render 'edit'
    end
  end

	def show
  	@user = User.find(params[:id])
	end

  # def new
  #   @user = User.new 
  # end

  def edit
    @user = User.find(params[:id])
    @products = @user.cart.carts_products
  end
  
  def destroy
    @user = User.find(params[:id])
    @user_id = @user.id 
    @user.destroy
    #redirect_to categories_path
  end

  def payment_history
    @user = User.find(params[:id])
    @payment_history = @user.user_charges
  end
 
	private
	def user_params
		params.require(:user).permit(addresses_attributes: [:id, :name, :mobile, :pincode, :address, :city, :state, :address_type, :_destroy])
	end
end
