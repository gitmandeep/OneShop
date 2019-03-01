class UsersController < ApplicationController
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

	private
	def user_params
		params.require(:user).permit(addresses_attributes: [:id, :name, :mobile, :pincode, :address, :city, :state, :address_type, :_destroy])
	end
end
