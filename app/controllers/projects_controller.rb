class ProjectsController < ApplicationController
	respond_to :json
	def index
		@projects=Project.all
	end
	def create
		project=Project.create post_params(params)
		project.save
		respond_with project
	end
	def show
		@project=Project.find(params[:id])
		return @project
	end
	private
	def post_params(params)
		params.require(:project).permit(:name,:description)
	end

end
