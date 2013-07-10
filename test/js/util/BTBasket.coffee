BTBasket = {
  addToBasket : (name, value) ->
    basket = $.cookie(name)

    ###
    trace "existing basket is"
    trace basket

    trace "about to add the following value"
    trace value
  ###

    if not basket?
      basket = []
    else
      basket = JSON.parse(basket)

    basket.push value

    ###trace "basket after add is"
    trace basket

###
    $.cookie(name, JSON.stringify(basket), { path: '/' })
  ,
  getBasketContents : (name) ->
    $.cookie(name)
  ,
  clearBasket : (name) ->
    $.removeCookie(name, { path: '/' })
  ,
  each : (name, cb) ->
    basket = $.cookie(name)

    if not basket then return

    trace "basket is"
    trace basket

    b = JSON.parse(basket)
    trace "basket parse ok", "BTBasket"

    $(b).each(->
      trace "in each for basket"
      trace this
      if cb? then cb.apply this
    )
  ,
  count : (name) ->
    try
      basket = $.cookie(name)

      if not basket then return 0

      trace "basket has content", "BTBasket"

      b = JSON.parse(basket)
      trace "basket parse ok", "BTBasket"
      return b.length
    catch error
      trace error

    0
}