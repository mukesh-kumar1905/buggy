class App.Views.Projects extends Backbone.View
	className:""
	initialize: ->
		@collection.on "reset",@render,@
		@collection.fetch({reset:true})
	template:HandlebarsTemplates["app/templates/projects"]
	render:->
		@$el.html(@template())
		@collection.each @renderProject,@
		@
	renderProject:(model)->
		v = new App.Views.Project({model:model})
		@$("ul").append(v.render().el) 