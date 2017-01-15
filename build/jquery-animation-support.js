
/*!
 * jquery-animation-support 1.0.3 | https://github.com/yivo/jquery-animation-support | MIT License
 */

(function() {
  (function(factory) {
    var __root__;
    __root__ = typeof self === 'object' && self !== null && self.self === self ? self : typeof global === 'object' && global !== null && global.global === global ? global : Function('return this')();
    if (typeof define === 'function' && typeof define.amd === 'object' && define.amd !== null) {
      define(['jquery'], function($) {
        return factory(__root__, document, setTimeout, $);
      });
    } else if (typeof module === 'object' && module !== null && typeof module.exports === 'object' && module.exports !== null) {
      factory(__root__, document, setTimeout, require('jquery'));
    } else {
      factory(__root__, document, setTimeout, $);
    }
  })(function(__root__, document, setTimeout, $) {
    var animationEnd;
    animationEnd = function() {
      var animEndEventNames, el, name;
      el = document.createElement('div');
      animEndEventNames = {
        WebkitAnimation: 'webkitAnimationEnd',
        MozAnimation: 'animationend',
        OAnimation: 'oAnimationEnd oanimationEnd',
        msAnimation: 'MSAnimationEnd',
        animation: 'animationend'
      };
      for (name in animEndEventNames) {
        if (el.style[name] != null) {
          return {
            end: animEndEventNames[name]
          };
        }
      }
      return false;
    };
    $.fn.emulateAnimationEnd = function(duration) {
      var $el, callback, called;
      called = false;
      $el = this;
      $el.one('animationEnd', function() {
        called = true;
      });
      callback = function() {
        if (!called) {
          $el.trigger($.support.animation.end);
        }
      };
      setTimeout(callback, duration);
      return this;
    };
    $(function() {
      var handler;
      $.support.animation = animationEnd();
      if ($.support.animation) {
        handler = function(e) {
          if (e.target === this) {
            e.handleObj.handler.apply(this, arguments);
          }
        };
        $.event.special.animationEnd = {
          bindType: $.support.animation.end,
          delegateType: $.support.animation.end,
          handle: handler
        };
      }
    });
  });

}).call(this);
