class SessionsController < ApplicationController
	respond_to :json
	def create
		@user=login(params[:email],params[:password])
		render status:422 unless @user
		@user
	end
end
