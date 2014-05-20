Backbone.View.prototype.leave= ->
	@remove()
	@off()
	@childViews?.forEach (v)-> v.leave()