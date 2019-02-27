class UsersController < ApplicationController
	def update
	end

	def show
  	@user = User.find(params[:id])
	end

private
	def user_params
		params.require(:user).permit([:name, :mobile, :pincode, :address, :city, :state, :address_type])
	end	
end
