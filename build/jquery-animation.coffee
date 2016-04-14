((factory) ->

  # Browser and WebWorker
  root = if typeof self is 'object' and self isnt null and self.self is self
    self

  # Server
  else if typeof global is 'object' and global isnt null and global.global is global
    global

  # AMD
  if typeof define is 'function' and typeof define.amd is 'object' and define.amd isnt null
    define ['jquery', 'exports'], ($) ->
      factory(root, document, setTimeout, $)

  # CommonJS
  else if typeof module is 'object' and module isnt null and
          typeof module.exports is 'object' and module.exports isnt null
    factory(root, document, setTimeout, require('jquery'))

  # Browser and the rest
  else
    factory(root, document, setTimeout, root.$)

  # No return value
  return

)((__root__, document, setTimeout, $) ->
  animationEnd = ->
    el = document.createElement('div')
  
    animEndEventNames =
      WebkitAnimation: 'webkitAnimationEnd'
      MozAnimation   : 'animationend'
      OAnimation     : 'oAnimationEnd oanimationEnd'
      msAnimation    : 'MSAnimationEnd'
      animation      : 'animationend'
  
    for name of animEndEventNames
      return end: animEndEventNames[name] if el.style[name]?
  
    false
  
  $.fn.emulateAnimationEnd = (duration) ->
    called = no
    $el    = this
    $el.one 'animationEnd', -> called = yes
  
    callback = ->
      $el.trigger($.support.animation.end) unless called
      return
  
    setTimeout(callback, duration)
    this
  
  $ ->
    $.support.animation = animationEnd()
  
    return unless $.support.animation
  
    $.event.special.animationEnd =
      bindType:     $.support.animation.end,
      delegateType: $.support.animation.end,
      handle:       (e) -> e.handleObj.handler.apply(this, arguments) if $(e.target).is(this)
  
  # No global variable export
  return
)