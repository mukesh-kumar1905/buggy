class App.Models.Issue extends Backbone.Model
	urlRoot:'/issues'
	validate:(attrs,options)->
		errors={}
		unless attrs.name
			errors.name=["can't be blank"]
		unless attrs.description
			errors.description=["can't be blank"]
		errors unless _.isEmpty errors


