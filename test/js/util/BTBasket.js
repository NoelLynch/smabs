var BTBasket;

BTBasket = {
  addToBasket: function(name, value) {
    var basket;
    basket = $.cookie(name);
    /*
    trace "existing basket is"
    trace basket
    
    trace "about to add the following value"
    trace value
    */

    if (basket == null) {
      basket = [];
    } else {
      basket = JSON.parse(basket);
    }
    basket.push(value);
    /*trace "basket after add is"
    trace basket
    */

    return $.cookie(name, JSON.stringify(basket), {
      path: '/'
    });
  },
  getBasketContents: function(name) {
    return $.cookie(name);
  },
  clearBasket: function(name) {
    return $.removeCookie(name, {
      path: '/'
    });
  },
  each: function(name, cb) {
    var b, basket;
    basket = $.cookie(name);
    if (!basket) {
      return;
    }
    trace("basket is");
    trace(basket);
    b = JSON.parse(basket);
    trace("basket parse ok", "BTBasket");
    return $(b).each(function() {
      trace("in each for basket");
      trace(this);
      if (cb != null) {
        return cb.apply(this);
      }
    });
  },
  count: function(name) {
    var b, basket, error;
    try {
      basket = $.cookie(name);
      if (!basket) {
        return 0;
      }
      trace("basket has content", "BTBasket");
      b = JSON.parse(basket);
      trace("basket parse ok", "BTBasket");
      return b.length;
    } catch (_error) {
      error = _error;
      trace(error);
    }
    return 0;
  }
};
