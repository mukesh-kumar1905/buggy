class App.Views.NewProject extends Backbone.View
	template:HandlebarsTemplates["app/templates/new_project"]
	events:
		"click button.btn":"createProject"
	createProject:(e)->
		e.preventDefault()
		@model.set name:@$("#name").val()
		@model.set description:@$("#description").val()
		@model.save()
	render:->
		@$el.html(@template())
		@