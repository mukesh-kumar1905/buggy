class App.Models.Project extends Backbone.Model
	urlRoot:'/projects'
	initialize:->
		@listenTo @,"change:issues",@convertIssues
	validate:(attrs,options)->
		errors={}
		unless attrs.name
			errors.name=["can't be blank"]
		unless attrs.description
			errors.description=["can't be blank"]
		errors unless _.isEmpty errors

	convertIssues:->
		@issues=new App.Collections.Issues(@get('issues'));
		