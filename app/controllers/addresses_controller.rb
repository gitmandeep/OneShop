class AddressesController < ApplicationController
	def new
    @user = User.find(params[:user_id])
		@products = @user.cart.carts_products
    # @address = @user.addresses.new
  end

  def create
    @user = User.find(params[:user_id])
    binding.pry
    @address = @user.addresses.create(user_params)
    # @address.save
  end

  private
	def address_params
    params.require(:user).require(:addresses_attributes).permit(:id, :name, :mobile, :pincode, :address, :city, :state, :address_type)
  end

  def user_params
    params.require(:user).permit(addresses_attributes: [:id, :name, :mobile, :pincode, :address, :city, :state, :address_type, :_destroy])
  end
end

