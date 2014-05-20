class App.Routers.MainRouter extends Backbone.Router

	routes:
		"":"index"
		"projects":"project"
		"projects/new":"newProject"
		"project/:id":"projectDetails"
		"projects/:id/edit":"projectEdit"
		"login":"login"

	login:->
		@layoutViews()
		@contentView.swapMain( new App.Views.Login({model:new App.Models.Login()}))

	newProject:->
		@layoutViews()
		@contentView.swapMain( new App.Views.NewProject(model:new App.Models.Project))
		@contentView.swapSide( new App.Views.Projects({collection:new App.Collections.Projects}))

	initialize: ->
		@headerView=new App.Views.Header()
		@contentView=new App.Views.Content()

	index:->
		@layoutViews()
		@contentView.swapMain( new App.Views.Ads())
		@contentView.swapSide( new App.Views.News())

	project: ->
		@layoutViews()
		@contentView.swapMain( new App.Views.Empty())
		@contentView.swapSide( new App.Views.Projects({collection:new App.Collections.Projects}))

	layoutViews: ->
		$("#header").html(@headerView.render().el)
		$("#content").html(@contentView.render().el)

	projectDetails: (id)->
		@layoutViews()
		@contentView.swapMain(new App.Views.ProjectDetails(model:new App.Models.Project({id:id})))
		@contentView.swapSide( new App.Views.Projects({collection:new App.Collections.Projects}))

	projectEdit:(id)->
		@layoutViews()
		@contentView.swapMain(new App.Views.EditProject({model:new App.Models.Project({id:id})}))
		@contentView.swapSide( new App.Views.Projects({collection:new App.Collections.Projects}))
