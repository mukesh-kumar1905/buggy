class App.Views.Content extends Backbone.View
	className:"row"

	template:HandlebarsTemplates["app/templates/content"]
	render: ->
		@$el.html(@template())
		@


	swapMain: (v)->
		@changeCurrentMainView(v)
		@$('#main-area').html(@currentMainView.render().el)

	changeCurrentMainView: (v)->
		@currentMainView.remove if @currentMainView
		@currentMainView=v

	swapSide: (v)->
		@changeCurrentsideView(v)
		@$('#side-area').html(@currentsideView.render().el)

	changeCurrentsideView: (v)->
		@currentsideView.remove if @currentsideView
		@currentsideView=v