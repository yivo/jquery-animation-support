###!
# jquery-animation-support 1.0.3 | https://github.com/yivo/jquery-animation-support | MIT License
###

((factory) ->

  __root__ = 
    # The root object for Browser or Web Worker
    if typeof self is 'object' and self isnt null and self.self is self
      self

    # The root object for Server-side JavaScript Runtime
    else if typeof global is 'object' and global isnt null and global.global is global
      global

    else
      Function('return this')()

  # Asynchronous Module Definition (AMD)
  if typeof define is 'function' and typeof define.amd is 'object' and define.amd isnt null
    define ['jquery'], ($) ->
      factory(__root__, document, setTimeout, $)

  # Server-side JavaScript Runtime compatible with CommonJS Module Spec
  else if typeof module is 'object' and module isnt null and typeof module.exports is 'object' and module.exports isnt null
    factory(__root__, document, setTimeout, require('jquery'))

  # Browser, Web Worker and the rest
  else
    factory(__root__, document, setTimeout, $)

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
    called = false
    $el    = this
    $el.one 'animationEnd', ->
      called = true
      return
  
    callback = ->
      if not called
        $el.trigger($.support.animation.end)
      return
  
    setTimeout(callback, duration)
    this
  
  $ ->
    $.support.animation = animationEnd()
  
    if $.support.animation
      handler = (e) ->
        if e.target is this
          e.handleObj.handler.apply(this, arguments)
        return
      
      $.event.special.animationEnd =
        bindType:     $.support.animation.end
        delegateType: $.support.animation.end
        handle:       handler
    return
  # Nothing exported
  return
)