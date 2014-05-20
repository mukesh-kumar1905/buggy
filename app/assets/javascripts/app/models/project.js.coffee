class App.Models.Project extends Backbone.Model
	urlRoot:'/projects'
	validate:(attrs,options)->
		errors={}
		unless attrs.name
			errors.name=["can't be blank"]
		unless attrs.description
			errors.description=["can't be blank"]
		errors unless _.isEmpty errors

