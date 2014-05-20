class App.Routers.MainRouter extends Backbone.Router

	routes:
		"":"index"
		"projects":"project"
		"projects/new":"newProject"
		"project/:id":"projectDetails"
		"projects/:id/edit":"projectEdit"
		"login":"login"
		"logout":"logout"

	login:->
		if App.CurrentUser.get('loggedIn')
			@project()
		else
			@layoutViews()
			@contentView.swapMain( new App.Views.Login({model:new App.Models.Login()}))

	logout:->
		App.Vent.trigger "user:logged_out"

	loginFromLogout:->
		@layoutViews()
		@contentView.swapMain( new App.Views.Login({model:new App.Models.Login()}))

	newProject:->
		@layoutViews()
		if App.CurrentUser.get("loggedIn")
			v=new App.Views.NewProject(model:new App.Models.Project)
		else
			v=new App.Views.AccessDenied()
		@contentView.swapMain( v)
		@contentView.swapSide( new App.Views.Projects({collection:new App.Collections.Projects}))

	initialize: ->
		@headerView=new App.Views.Header()
		@contentView=new App.Views.Content()
		@listenTo App.Vent,"user:logged_out",@loginFromLogout

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
