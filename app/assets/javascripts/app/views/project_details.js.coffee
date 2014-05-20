class App.Views.ProjectDetails extends Backbone.View
	template:HandlebarsTemplates['app/templates/project_details']
	initialize:->
		@listenTo @model,"sync",@render
		@model.fetch()

	events:
		"click button.destroy":"deleteProject"

	deleteProject:(e)->
		return unless confirm("Are you sure you want to delete #{@model.get('name')}?")
		@model.destroy
			success:-> App.Vent.trigger "project:delete"

	render:->
		@$el.html(@template(@model.toJSON()))
		@
