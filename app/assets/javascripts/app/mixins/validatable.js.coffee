App.Mixins.Validatable=
	renderErrors:(model,errors)->
		@clearErrors()
		_.each errors,@renderError ,@

	renderError:(errors,attr)->
		err=errors.join "; "
		@$("#"+attr).closest("div.form-group").addClass("has-error")
		@$("#"+attr).closest("div.controls").append("<span class='help-block'>#{err}<span>")

	parseErrorResponse:(model,resp)->
		if resp and resp.status is 403
			App.Vent.trigger "access_denied"
		else if resp and resp.responseText
			errors=JSON.parse resp.responseText
			@renderErrors(model,errors.errors)

	clearErrors:->
		@$("div.has-error").removeClass('has-error')
		@$("span.help-block").remove()
