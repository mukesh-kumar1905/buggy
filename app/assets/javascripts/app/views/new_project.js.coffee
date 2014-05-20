class App.Views.NewProject extends Backbone.View
	template:HandlebarsTemplates["app/templates/new_project"]
	initialize:->
		@listenTo @model,"sync",@render
		@listenTo @model,"invalid",@renderErrors
		@listenTo @model,"error",@parseErrorResponse
		@model.fetch() unless @model.isNew()
	events:
		"click button.btn":"createProject"

	createProject:(e)->
		e.preventDefault()
		@model.set name:@$("#name").val()
		@model.set description:@$("#description").val()
		@model.save {},
			success:(model)->App.Vent.trigger "project:create",model

	render:->
		@$el.html(@template())
		@
	
_.extend App.Views.NewProject.prototype,App.Mixins.Validatable