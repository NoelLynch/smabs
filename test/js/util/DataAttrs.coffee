###
  data-validate flags that this component should be checked for empty values

  e.g.
  <input data-validate="You must enter a password" />

  If successful execute callback

  data-bind, data-bind-format, data-bind-target used for quick data binding on elements in the dom

  <p data-bind="receiptAmount" data-bind-format="FixedNumber" data-bind-target="text">Receipt Amount $0</p>

  DataAttributes.bindTo(result)   # where result has a property receiptAmount
###
DataAttributes = {
  validate : (cb) ->
    valid = true

    $("[data-validate]").each(->
      if $(this).val() is ""
        alert $(this).attr "data-validate"
        valid = false
    )

    if valid and cb?
      cb()

  bindTo : (obj, cb) ->
    $("[data-bind]").each(->
      prop = $(this).attr "data-bind"
      method = $(this).attr "data-bind-format"
      target = $(this).attr "data-bind-target"

      if not method?
        method = "String"

      if obj[prop]? and target?
        result = null

        switch method
          when "String" then result = obj[prop].toString()
          when "FixedNumber" then result = parseFloat(obj[prop]).toFixed(2)

        str = $(this)[target]()

        if str?
          str = str.replace("$0", result)
          $(this)[target] str
        else
          trace "no str defined for binding"
      else
        trace "no #{prop} on object"
    )
}

$ = jQuery

$.fn.extend
  bindTo: (obj) ->
    this.find("[data-bind]").each(->
      prop = $(this).attr "data-bind"
      method = $(this).attr "data-bind-format"
      target = $(this).attr "data-bind-target"
      expr = $(this).attr "data-bind-expr"
      isAttr = $(this).attr "data-bind-attr"

      if not method?
        method = "String"

      if obj[prop]? and target?
        result = null

        switch method
          when "String" then result = obj[prop].toString()
          when "FixedNumber" then result = parseFloat(obj[prop]).toFixed(2)

        if not expr? then str = $(this)[target]() else str = expr

        if str?
          str = str.replace("$0", result)

          if not isAttr?
            $(this)[target] str
          else
            $(this).attr target, str
        else
          trace "no str defined for binding"
      else
        trace "no #{prop} on object"
    )

  validate : (cb) ->
    valid = true
    this.find("[data-validate]").each(->
      if $(this).val() is ""
        alert $(this).attr "data-validate"
        valid = false
    )

    if valid and cb?
      cb()