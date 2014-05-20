class App.Views.Header extends Backbone.View
	className:"navbar navbar-default navbar-static-top"

	template:HandlebarsTemplates['app/templates/header']

	initialize:->
		@listenTo App.CurrentUser,"change:loggedIn",@render

	render: ->
		@$el.html(@template({current_user:App.CurrentUser.get("loggedIn")})) 
		@