(function() {
  (function(factory) {
    var root;
    root = typeof self === 'object' && self !== null && self.self === self ? self : typeof global === 'object' && global !== null && global.global === global ? global : void 0;
    if (typeof define === 'function' && typeof define.amd === 'object' && define.amd !== null) {
      define(['jquery', 'exports'], function($) {
        return factory(root, document, $);
      });
    } else if (typeof module === 'object' && module !== null && typeof module.exports === 'object' && module.exports !== null) {
      factory(root, document, require('jquery'));
    } else {
      factory(root, document, root.$);
    }
  })(function(__root__, document, $) {
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
