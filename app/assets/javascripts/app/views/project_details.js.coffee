class App.Views.ProjectDetails extends Backbone.View
	template:HandlebarsTemplates['app/templates/project_details']
	initialize:->
		@listenTo @model,"sync",@render
		@model.fetch()

	events:
		"click button.destroy":"deleteProject"
		"click button.edit":"editProject"

	deleteProject:(e)->
		return unless confirm("Are you sure you want to delete #{@model.get('name')}?")
		@model.destroy
			success:-> App.Vent.trigger "project:delete"

	editProject:(e)->
		App.Vent.trigger "project:edit",@model

	render:->
		@$el.html(@template(@model.toJSON()))
		@
