class ProjectsController < ApplicationController
	respond_to :json
	before_filter :authenticated ,only:[:create]
	before_filter :owner ,only:[:update,:destroy]

	def index
		@projects=Project.all
	end
	def create
		project=Project.create post_params(params)
		project.save
		respond_with project
	end
	def show
		@project=Project.includes(:issues).find(params[:id])
		return @project
	end
	def update
		respond_with @project.update_attributes(post_params(params))
	end
	def destroy
		@project.destroy
		respond_with @project
	end
	private
	def post_params(params)
		params.require(:project).permit(:name,:description)
	end
	def authenticated
		if cannot? :create , Project
			render status: :forbidden,text:"Forbidden"
		end
	end
	def owner
		@project=Project.find(params[:id])
		if cannot? params[:action].to_s ,@project
			render status: :forbidden,text:"Forbidden"
		end
	end
end
