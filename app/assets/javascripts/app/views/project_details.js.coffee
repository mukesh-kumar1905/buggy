class App.Views.ProjectDetails extends Backbone.View
	template:HandlebarsTemplates['app/templates/project_details']
	initialize:->
		if @model.get('user_id') is App.CurrentUser.id
			@model.set owned:true
		console.log(@model.get('owned'))
		@childViews=[]
		@listenTo @model,"change",@renderDetails
		@listenTo @model,"sync",@renderDetails
		@listenTo @model,"error",@triggerAccessDenied
		@listenTo @model,"destroy",@triggerProjectDestroy
		@model.fetch()

	events:
		"click button.destroy":"deleteProject"
		"click button.edit":"editProject"

	deleteProject:(e)->
		return unless confirm("Are you sure you want to delete #{@model.get('name')}?")
		@model.destroy({wait:true})

	editProject:(e)->
		App.Vent.trigger "project:edit",@model

	render:->
		@$el.html(@template(@model.toJSON()))
		@

	renderDetails:->
		@$el.html(@template(@model.toJSON()))
		
		v=new App.Views.Issues({collection:@model.issues})
		@childViews.push(v)
		@$('#issues').html(v.render().el)
		
		v1= new App.Views.NewIssue({ model : new App.Models.Issue({project_id:@model.id})})
		@childViews.push(v1)
		@$("#new_issues").html(v1.render().el)

		@

	triggerProjectDestroy:->
		App.Vent.trigger "project:delete"

	triggerAccessDenied:->App.Vent.trigger "access_denied"
