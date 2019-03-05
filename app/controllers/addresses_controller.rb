class AddressesController < ApplicationController
	def destroy
    @user = User.find(params[:user_id])
    @address = @user.addresses.find(params[:id])
    @address.destroy
  end

  def edit
    @user = User.find(params[:user_id])
    @address = @user.addresses.find(params[:id])
  end
end

