class App.Views.NewProject extends Backbone.View
	template:HandlebarsTemplates["app/templates/new_project"]
	initialize:->
		@listenTo @model,"invalid",@renderErrors
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
	renderErrors:(model,errors)->
		@$("div.has-error").removeClass('has-error')
		@$("span.help-block").remove()
		_.each errors,@renderError ,@

	renderError:(errors,attr)->
		err=errors.join "; "
		@$("#"+attr).closest("div.form-group").addClass("has-error")
		@$("#"+attr).closest("div.controls").append("<span class='help-block'>#{err}<span>")
