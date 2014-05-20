class App.Views.Login extends Backbone.View
	template: HandlebarsTemplates['app/templates/login']

	initialize:->
		@listenTo @model,"error",@renderError

	renderError:->
		@$('.alert').html("Credentials are not valid").show() 

	events:
		"click button":"login"

	login:(e)->
		e.preventDefault();
		@model.set email:@$('#email').val()
		@model.set password:@$('#password').val()
		@model.save()

	render: ->
		@$el.html(@template(@model.toJSON()))
		@