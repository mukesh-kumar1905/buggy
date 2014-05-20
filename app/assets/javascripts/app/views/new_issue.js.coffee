class App.Views.NewIssue extends Backbone.View
	template:HandlebarsTemplates["app/templates/new_issue"]
	initialize:->
		@listenTo @model,"invalid",@renderErrors
		@listenTo @model,"error",@parseErrorResponse
		@listenTo @model,"sync",@success
		@model.fetch() unless @model.isNew()
	events:
		"click button.btn":"createIssue"

	createIssue:(e)->
		e.preventDefault()
		@model.set name:@$("#name").val()
		@model.set description:@$("#description").val()
		@model.save()

	render:->
		@$el.html(@template(@model.toJSON()))
		@

	success:()->
		@clearForm()
		App.Vent.trigger "issue:create" ,@model.clone()

	clearForm:->
		@$("#name").val("")
		@$("#description").val("")
		@clearErrors
		delete @model.id
		delete @model.attributes.id

_.extend App.Views.NewIssue.prototype,App.Mixins.Validatable