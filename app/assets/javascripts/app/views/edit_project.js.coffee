class App.Views.EditProject extends Backbone.View
	template:HandlebarsTemplates["app/templates/edit_project"]
	initialize:->
		@listenTo @model,"sync",@render
		@model.fetch() unless @model.isNew()
	events:
		"click button.btn":"editProject"

	editProject:(e)->
		e.preventDefault()
		@model.set name:@$("#name").val()
		@model.set description:@$("#description").val()
		@model.save {},
			success:(model)->App.Vent.trigger "project:show",model

	render:->
		@$el.html(@template(@model.toJSON()))
		@