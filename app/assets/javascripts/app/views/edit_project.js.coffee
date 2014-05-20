class App.Views.EditProject extends Backbone.View
	template:HandlebarsTemplates["app/templates/edit_project"]
	initialize:->
		@listenTo @model,"sync",@render
		@listenTo @model,"invalid",@renderErrors
		@listenTo @model,"error",@parseErrorResponse
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

	renderErrors:(model,errors)->
		@$("div.has-error").removeClass('has-error')
		@$("span.help-block").remove()
		_.each errors,@renderError ,@

	renderError:(errors,attr)->
		err=errors.join ";"
		@$("#"+attr).closest("div.form-group").addClass("has-error")
		@$("#"+attr).closest("div.controls").append("<span class='help-block'>#{err}<span>")

	parseErrorResponse:(model,resp)->
		if resp and resp.responseText
			errors=JSON.parse resp.responseText
			@renderErrors(model,errors.errors)