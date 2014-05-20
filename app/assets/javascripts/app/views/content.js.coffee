class App.Views.Content extends Backbone.View
	className:"row"

	initialize:->
		@listenTo App.Vent,"project:create",@projectShow
		@listenTo App.Vent,"project:new",@swapMainToNew
		@listenTo App.Vent,"project:show",@projectShow
		@listenTo App.Vent,"project:delete",@swapMainToEmpty
		@listenTo App.Vent,"project:edit",@swapMainToEdit
		@listenTo App.Vent ,"user:logged_in",@swapMainToLoggedInView
		@listenTo App.Vent ,"user:logged_out",@swapMainToEmpty
		@listenTo App.Vent ,"access_denied",@accessDenied

	swapMainToLoggedInView:->
		@swapMainToEmpty()
		@swapSide( new App.Views.Projects({collection:new App.Collections.Projects}))
		
	accessDenied:->
		@swapMain(new App.Views.AccessDenied())

	template:HandlebarsTemplates["app/templates/content"]

	render: ->
		@$el.html(@template())
		@

	
	swapMainToEmpty:->
		@swapMain(new App.Views.Empty())

	swapMainToNew:->
		@swapMain( new App.Views.NewProject(model:new App.Models.Project))
		Backbone.history.navigate("/projects/new")

	swapMain: (v)->
		@changeCurrentMainView(v)
		@$('#main-area').html(@currentMainView.render().el)

	changeCurrentMainView: (v)->
		@currentMainView.leave() if @currentMainView
		@currentMainView=v

	swapSide: (v)->
		@changeCurrentsideView(v)
		@$('#side-area').html(@currentsideView.render().el)

	changeCurrentsideView: (v)->
		@currentsideView.leave() if @currentsideView
		@currentsideView=v

	projectShow: (model)->
		@swapMain(new App.Views.ProjectDetails({model:model}))
		Backbone.history.navigate("/project/#{model.id}")

	swapMainToEdit:(model)->
		@swapMain(new App.Views.EditProject({model:model}))
		Backbone.history.navigate("/projects/#{model.id}/edit")