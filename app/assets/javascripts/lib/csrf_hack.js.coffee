$ ->
	token=$('meta[name="csrf-token"]').attr("content")
	$.ajaxSetup
		beforeSend: (xhr,settings)->
			return if (settings.type is "GET")
			xhr.setRequestHeader('X-CSRF-TOKEN',token) if token
