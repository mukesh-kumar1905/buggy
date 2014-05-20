class App.Models.CurrentUser extends Backbone.Model
	
	initialize:->
		@listenTo App.Vent ,"user:logged_in",@login
		@listenTo App.Vent ,"user:logged_out",@logout

	login:(id,email)->
		@set({id:id,email:email,loggedIn:true})

	logout:->
		console.log @id
		m=new App.Models.Login({id:@id})
		console.log m.toJSON()
		m.destroy
			success:=>
				@set loggedIn:false
				delete @id
				delete @attributes.email
				delete @attributes.id