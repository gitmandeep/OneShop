class AddressesController < ApplicationController
	def new
    @user = User.find(params[:user_id])
		@products = CartsProduct.all
    @address = @user.addresses.new
  end

  def create
  	@user = User.find(params[:user_id])
    @address = @user.addresses.build(address_params)
    @address.save
  end

private
	def address_params
    params.require(:user).permit(:name, :mobile, :pincode, :address, :city, :state, :address_type)
  end
end

