class HomeController < ApplicationController

	def index
		@message = current_user.messages.build if logged_in?
	end

	def show
		@user = User.find(params[:id])
	end


end
