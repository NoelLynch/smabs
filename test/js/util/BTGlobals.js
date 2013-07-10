var BTGlobals, capitalize, getWindowSize, objToString, trace;

BTGlobals = {
  netLogging: true
};

if ((typeof console !== "undefined" && console !== null ? console.clear : void 0) != null) {
  console.clear();
}

trace = function(msg, from) {
  if (typeof console !== "undefined" && console !== null) {
    if (from != null) {
      if ($.type(msg) === "object") {
        return console.log("" + from + " :: " + (objToString(msg)));
      } else {
        return console.log("" + from + " :: " + msg);
      }
    } else {
      return console.log(msg);
    }
  }
};

capitalize = function(str) {
  str = str.toLowerCase();
  return str.replace(/([^ -])([^ -]*)/gi, function(v, v1, v2) {
    return v1.toUpperCase() + v2;
  });
};

objToString = function(obj) {
  return JSON.stringify(obj);
};

/*
  http://www.howtocreate.co.uk/tutorials/javascript/browserwindow
*/


getWindowSize = function() {
  var myHeight, myWidth;
  myWidth = 0;
  myHeight = 0;
  if (typeof window.innerWidth === 'number') {
    myWidth = window.innerWidth;
    myHeight = window.innerHeight;
  } else if (document.documentElement && (document.documentElement.clientWidth || document.documentElement.clientHeight)) {
    myWidth = document.documentElement.clientWidth;
    myHeight = document.documentElement.clientHeight;
  } else if (document.body && (document.body.clientWidth || document.body.clientHeight)) {
    myWidth = document.body.clientWidth;
    myHeight = document.body.clientHeight;
  }
  return {
    w: myWidth,
    h: myHeight
  };
};
