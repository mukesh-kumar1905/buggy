#= require_self
#= require_tree ./mixins
#= require_tree ./models
#= require_tree ./collections
#= require_tree ./templates
#= require_tree ./views
#= require_tree ./routers

window.App=
	Routers:{}
	Views:{}
	Collections:{}
	Models:{}
	Mixins:{}
	Vent:_.clone(Backbone.Events)
	initialize:(data) ->
		App.CurrentUser=new App.Models.CurrentUser(data.current_user)
		new App.Routers.MainRouter()
		Backbone.history.start()