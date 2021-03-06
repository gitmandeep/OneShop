class AddressesController < ApplicationController
	def destroy
    @user = User.find(params[:user_id])
    @address = @user.addresses.find(params[:id])
    @address.destroy
  end

  def edit
    @user = User.find(params[:user_id])
    @address = @user.addresses.create(user_params)
    # @address.save
  end

  private
	def address_params
    params.require(:user).require(:addresses_attributes).permit(:id, :name, :mobile, :pincode, :address, :city, :state, :address_type)
  end

  def user_params
    params.require(:user).permit(addresses_attributes: [:id, :name, :mobile, :pincode, :address, :city, :state, :address_type, :_destroy])
    @address = @user.addresses.find(params[:id])

  end
end

