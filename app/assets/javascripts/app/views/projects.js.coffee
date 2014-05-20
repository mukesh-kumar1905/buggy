class App.Views.Projects extends Backbone.View
	className:""
	template:HandlebarsTemplates["app/templates/projects"]
	events:
		"click a.btn":"newProject"
	newProject:(e)->
		e.preventDefault()
		App.Vent.trigger "project:new"

	initialize: ->
		@childViews=[]
		@collection.on "reset",@render,@
		@collection.on "add",@renderProject,@
		@collection.fetch({reset:true})
		@listenTo App.Vent, "project:create",@addToCollection
		@listenTo App.Vent, "remove",@leave
			
	addToCollection:(model)->
		@collection.add model

	render:->
		@$el.html(@template())
		@collection.each @renderProject,@
		@

	renderProject:(model)->
		v = new App.Views.Project({model:model})
		@childViews.push(v)
		@$("ul").append(v.render().el)

	

		