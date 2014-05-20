class App.Views.Project extends Backbone.View
	template: HandlebarsTemplates['app/templates/project']

	initialize: ->
		@listenTo @model,"destroy",@remove


	render:->
		@$el.html(@template(@model.toJSON()))
		@

	events:
		"click a":"showDetails"

	showDetails: (e)->
		e.preventDefault()
		App.Vent.trigger "project:show",@model
		Backbone.history.navigate("project/#{@model.id}")


