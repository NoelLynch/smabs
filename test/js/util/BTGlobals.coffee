BTGlobals = {
  netLogging : true
}

if console?.clear?
  console.clear()

trace = (msg, from) ->
  if console?
    if from?
      if $.type(msg) is "object"
        console.log("#{from} :: #{objToString(msg)}")
      else
        console.log("#{from} :: #{msg}")
    else console.log(msg)

capitalize = (str) ->
  str = str.toLowerCase();
  str.replace /([^ -])([^ -]*)/gi, (v,v1,v2) -> v1.toUpperCase() + v2

objToString = (obj) ->
  JSON.stringify obj

###
  http://www.howtocreate.co.uk/tutorials/javascript/browserwindow
###
getWindowSize = ->
  myWidth = 0
  myHeight = 0
  if typeof( window.innerWidth ) is 'number'
    # Non-IE
    myWidth = window.innerWidth
    myHeight = window.innerHeight
  else if( document.documentElement && ( document.documentElement.clientWidth || document.documentElement.clientHeight ) )
    # IE 6+ in 'standards compliant mode'
    myWidth = document.documentElement.clientWidth;
    myHeight = document.documentElement.clientHeight;
  else if( document.body && ( document.body.clientWidth || document.body.clientHeight ) )
    # IE 4 compatible
    myWidth = document.body.clientWidth;
    myHeight = document.body.clientHeight;

  return { w : myWidth, h : myHeight }

