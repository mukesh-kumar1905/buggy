class App.Views.Project extends Backbone.View
	template: HandlebarsTemplates['app/templates/project']

	render:->
		@$el.html(@template(@model.toJSON()))
		@

	events:
		"click a":"showDetails"

	showDetails: (e)->
		e.preventDefault()
		App.Vent.trigger "project:show",@model
