class App.Views.NewProject extends Backbone.View
	template:HandlebarsTemplates["app/templates/new_project"]
	initialize:->
		@listenTo @model,"invalid",@renderErrors
		@listenTo @model,"error",@parseErrorResponse
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

	parseErrorResponse:(model,resp)->
		if resp and resp.responseText
			errors=JSON.parse resp.responseText
			@renderErrors(model,errors.errors)
