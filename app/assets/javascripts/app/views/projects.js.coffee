class App.Views.Projects extends Backbone.View
	className:""
	template:HandlebarsTemplates["app/templates/projects"]
	render:->
		@$el.html(@template())
		@
