class App.Views.Issues extends Backbone.View

	template:HandlebarsTemplates["app/templates/issues"]

	initialize:->
		@childViews=[]
		@listenTo App.Vent,"issue:create",@addToCollection
		@listenTo @collection,"add",@renderIssue
		@listenTo @collection,"add",@updateCounter

	render:->
		@$el.html(@template(count:@collection.length))
		@collection.forEach @renderIssue,@
		@
	
	renderIssue:(model)->
		v = new App.Views.Issue({model:model})
		@childViews.push(v)
		@$("#issues_list").append(v.render().el)
		model=new App.Models.Issue({project_id:model.get('project_id')})


	addToCollection:(model)->
		@collection.add model
		App.Vent.trigger "issues:change",model,@collection.length


	updateCounter:->
		@$('span').text(@collection.length)