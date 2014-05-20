class App.Models.CurrentUser extends Backbone.Model
	
	initialize:->
		@listenTo App.Vent ,"user:logged_in",@login

	login:(id,email)->
		@set({id:id,email:email,loggedIn:true})