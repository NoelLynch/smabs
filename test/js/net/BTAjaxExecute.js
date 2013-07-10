var ajaxCall;

ajaxCall = function(url, params, callback, fail) {
  if (BTGlobals.netLogging) {
    trace("calling ajax : " + url);
  }
  return $.ajax({
    url: url,
    type: 'POST',
    timeout: 15000,
    data: params,
    dataType: 'json',
    success: function(json) {
      if (BTGlobals.netLogging) {
        trace("got response back " + (json.toString()), "ajaxCall.success");
      }
      if (json.status === "ok" && (callback != null)) {
        return callback(json.result);
      } else if (fail != null) {
        return fail(json.message);
      } else {
        trace(json);
        return alert(json.message);
      }
    },
    error: function(req, msg, err) {
      var str;
      str = "An error occurred communicating with the server. Cause : " + err;
      if (fail != null) {
        return fail(str);
      } else {
        trace(str, "ajaxCall.fail");
        return alert(str);
      }
    }
  });
};
