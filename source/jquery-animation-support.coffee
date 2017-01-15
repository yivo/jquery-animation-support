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
