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
      factory(root, document, $)

  # CommonJS
  else if typeof module is 'object' and module isnt null and
          typeof module.exports is 'object' and module.exports isnt null
    factory(root, document, require('jquery'))

  # Browser and the rest
  else
    factory(root, document, root.$)

  # No return value
  return

)((__root__, document, $) ->
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
  # No global variable export
  return
)