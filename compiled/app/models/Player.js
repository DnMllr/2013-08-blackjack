// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.Player = (function(_super) {
    __extends(Player, _super);

    function Player() {
      _ref = Player.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Player.prototype.initialize = function(params) {
      var _this = this;
      this.set('chips', 0);
      this.set('name', params.name);
      this.set('isDealer', params.isDealer);
      this.set('busted', false);
      this.set('hand', new Hand());
      return this.listenTo(this.get('hand'), 'bust', function() {
        return _this.set('busted', true);
      });
    };

    Player.prototype.hit = function() {
      return this.trigger('I_want_to_hit', this);
    };

    return Player;

  })(Backbone.Model);

}).call(this);

/*
//@ sourceMappingURL=Player.map
*/
