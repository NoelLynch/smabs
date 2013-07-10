ajaxCall = (url, params, callback, fail)->
  if BTGlobals.netLogging
    trace "calling ajax : " + url

  $.ajax {
    url : url,
    type : 'POST',
    timeout : 15000,
    data : params,
    dataType : 'json',
    success : (json) ->
      if BTGlobals.netLogging
        trace "got response back #{json.toString()}", "ajaxCall.success"

      if json.status is "ok" and callback?
        callback json.result
      else if fail?
        fail json.message
      else
        trace json
        alert json.message
    ,
    error : (req, msg, err) ->
      str = "An error occurred communicating with the server. Cause : #{err}"
      if fail?
        fail str
      else
        trace str, "ajaxCall.fail"
        alert str

  }
