// Generated by CoffeeScript 1.6.3
var KEY_CLASS,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

KEY_CLASS = (function() {
  function KEY_CLASS() {
    this.keyup = __bind(this.keyup, this);
    this.keydown = __bind(this.keydown, this);
  }

  KEY_CLASS.prototype.keys = [0xF, 0xF];

  KEY_CLASS.prototype.colidx = 0;

  KEY_CLASS.prototype.LEFT = 37;

  KEY_CLASS.prototype.UP = 38;

  KEY_CLASS.prototype.RIGHT = 39;

  KEY_CLASS.prototype.DOWN = 40;

  KEY_CLASS.prototype.A = 90;

  KEY_CLASS.prototype.B = 88;

  KEY_CLASS.prototype.START = 13;

  KEY_CLASS.prototype.SELECT = 32;

  KEY_CLASS.prototype.reset = function() {
    this.keys = [0xF, 0xF];
    return this.colidx = 0;
  };

  KEY_CLASS.prototype.rb = function() {
    switch (this.colidx) {
      case 0x10:
        return this.keys[0];
      case 0x20:
        return this.keys[1];
      default:
        return 0x00;
    }
  };

  KEY_CLASS.prototype.wb = function(v) {
    return this.colidx = v & 0x30;
  };

  KEY_CLASS.prototype.keydown = function(e) {
    switch (e.keyCode) {
      case this.RIGHT:
        return this.keys[1] &= 0xE;
      case this.LEFT:
        return this.keys[1] &= 0xD;
      case this.UP:
        return this.keys[1] &= 0xB;
      case this.DOWN:
        return this.keys[1] &= 0x7;
      case this.A:
        return this.keys[0] &= 0xE;
      case this.B:
        return this.keys[0] &= 0xD;
      case this.SELECT:
        return this.keys[0] &= 0xB;
      case this.START:
        return this.keys[0] &= 0x7;
    }
  };

  KEY_CLASS.prototype.keyup = function(e) {
    switch (e.keyCode) {
      case this.RIGHT:
        return this.keys[1] |= 0x1;
      case this.LEFT:
        return this.keys[1] |= 0x2;
      case this.UP:
        return this.keys[1] |= 0x4;
      case this.DOWN:
        return this.keys[1] |= 0x8;
      case this.A:
        return this.keys[0] |= 0x1;
      case this.B:
        return this.keys[0] |= 0x2;
      case this.SELECT:
        return this.keys[0] |= 0x4;
      case this.START:
        return this.keys[0] |= 0x8;
    }
  };

  return KEY_CLASS;

})();