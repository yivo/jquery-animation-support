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