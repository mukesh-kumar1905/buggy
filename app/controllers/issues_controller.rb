class IssuesController < ApplicationController
	respond_to :json
	def create
		@issue=Issue.new(post_params)
		@issue.save()
		@issue
	end
	def show
		respond_with Issue.find(params[:id])
	end
	private
	def post_params
		params.require(:issue).permit(:project_id,:name,:description)
	end
end
