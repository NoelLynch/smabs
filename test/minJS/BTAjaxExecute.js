var ajaxCall;ajaxCall=function(a,e,r,t){return BTGlobals.netLogging&&trace("calling ajax : "+a),$.ajax({url:a,type:"POST",timeout:15e3,data:e,dataType:"json",success:function(a){return BTGlobals.netLogging&&trace("got response back "+a.toString(),"ajaxCall.success"),"ok"===a.status&&null!=r?r(a.result):null!=t?t(a.message):(trace(a),alert(a.message))},error:function(a,e,r){var l;return l="An error occurred communicating with the server. Cause : "+r,null!=t?t(l):(trace(l,"ajaxCall.fail"),alert(l))}})};