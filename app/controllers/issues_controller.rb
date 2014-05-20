class IssuesController < ApplicationController
	respond_to :json
	def create
		@issue=Issue.new(post_params)
		@issue.save()
		respond_with @issue
	end
	private
	def post_params
		params.require(:issue).permit(:project_id,:name,:description)
	end
end
