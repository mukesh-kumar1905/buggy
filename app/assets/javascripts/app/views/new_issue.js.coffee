class App.Views.NewIssue extends Backbone.View
	template:HandlebarsTemplates["app/templates/new_issue"]
	initialize:->
		@listenTo @model,"invalid",@renderErrors
		@listenTo @model,"error",@parseErrorResponse
		@model.fetch() unless @model.isNew()
	events:
		"click button.btn":"createIssue"

	createIssue:(e)->
		e.preventDefault()
		@model.set name:@$("#name").val()
		@model.set description:@$("#description").val()
		@model.save {},
			success:(model)->App.Vent.trigger "issue:create",model

	render:->
		@$el.html(@template(@model.toJSON()))
		@
	
_.extend App.Views.NewIssue.prototype,App.Mixins.Validatable