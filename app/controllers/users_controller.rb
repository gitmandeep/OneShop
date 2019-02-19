class UsersController < ApplicationController
	def update
	end

private
	def user_params
		params.require(:user).permit([:name, :mobile, :pincode, :address, :city, :state, :address_type])
	end	
end
