class App.Views.Project extends Backbone.View
	template: HandlebarsTemplates['app/templates/project']

	initialize: ->
		@listenTo @model,"destroy",@remove
		@listenTo @model,"change:name",@render
		@listenTo App.Vent, "test",@log
		@listenTo App.Vent, "issues:change",@updateCounter

	render:->
		@$el.html(@template(@model.toJSON()))
		@

	events:
		"click a":"showDetails"

	log:->
		console.log("test")

	showDetails: (e)->
		e.preventDefault()
		App.Vent.trigger "project:show",@model
		Backbone.history.navigate("project/#{@model.id}")

	updateCounter:(model,count)->
		if model.get("project_id") is @model.id
			@$('span.badge').text(count)

