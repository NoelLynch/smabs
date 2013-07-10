/*
  data-validate flags that this component should be checked for empty values

  e.g.
  <input data-validate="You must enter a password" />

  If successful execute callback

  data-bind, data-bind-format, data-bind-target used for quick data binding on elements in the dom

  <p data-bind="receiptAmount" data-bind-format="FixedNumber" data-bind-target="text">Receipt Amount $0</p>

  DataAttributes.bindTo(result)   # where result has a property receiptAmount
*/

var $, DataAttributes;

DataAttributes = {
  validate: function(cb) {
    var valid;
    valid = true;
    $("[data-validate]").each(function() {
      if ($(this).val() === "") {
        alert($(this).attr("data-validate"));
        return valid = false;
      }
    });
    if (valid && (cb != null)) {
      return cb();
    }
  },
  bindTo: function(obj, cb) {
    return $("[data-bind]").each(function() {
      var method, prop, result, str, target;
      prop = $(this).attr("data-bind");
      method = $(this).attr("data-bind-format");
      target = $(this).attr("data-bind-target");
      if (method == null) {
        method = "String";
      }
      if ((obj[prop] != null) && (target != null)) {
        result = null;
        switch (method) {
          case "String":
            result = obj[prop].toString();
            break;
          case "FixedNumber":
            result = parseFloat(obj[prop]).toFixed(2);
        }
        str = $(this)[target]();
        if (str != null) {
          str = str.replace("$0", result);
          return $(this)[target](str);
        } else {
          return trace("no str defined for binding");
        }
      } else {
        return trace("no " + prop + " on object");
      }
    });
  }
};

$ = jQuery;

$.fn.extend({
  bindTo: function(obj) {
    return this.find("[data-bind]").each(function() {
      var expr, isAttr, method, prop, result, str, target;
      prop = $(this).attr("data-bind");
      method = $(this).attr("data-bind-format");
      target = $(this).attr("data-bind-target");
      expr = $(this).attr("data-bind-expr");
      isAttr = $(this).attr("data-bind-attr");
      if (method == null) {
        method = "String";
      }
      if ((obj[prop] != null) && (target != null)) {
        result = null;
        switch (method) {
          case "String":
            result = obj[prop].toString();
            break;
          case "FixedNumber":
            result = parseFloat(obj[prop]).toFixed(2);
        }
        if (expr == null) {
          str = $(this)[target]();
        } else {
          str = expr;
        }
        if (str != null) {
          str = str.replace("$0", result);
          if (isAttr == null) {
            return $(this)[target](str);
          } else {
            return $(this).attr(target, str);
          }
        } else {
          return trace("no str defined for binding");
        }
      } else {
        return trace("no " + prop + " on object");
      }
    });
  },
  validate: function(cb) {
    var valid;
    valid = true;
    this.find("[data-validate]").each(function() {
      if ($(this).val() === "") {
        alert($(this).attr("data-validate"));
        return valid = false;
      }
    });
    if (valid && (cb != null)) {
      return cb();
    }
  }
});
