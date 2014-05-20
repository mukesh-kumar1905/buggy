class App.Views.ProjectDetails extends Backbone.View
	template:HandlebarsTemplates['app/templates/project_details']
	initialize:->
		@childViews=[]
		@listenTo @model,"sync",@renderDetails
		@model.fetch()

	events:
		"click button.destroy":"deleteProject"
		"click button.edit":"editProject"

	deleteProject:(e)->
		return unless confirm("Are you sure you want to delete #{@model.get('name')}?")
		@model.destroy
			success:-> App.Vent.trigger "project:delete"

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

