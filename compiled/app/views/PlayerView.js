// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.PlayerView = (function(_super) {
    __extends(PlayerView, _super);

    function PlayerView() {
      _ref = PlayerView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    PlayerView.prototype.initialize = function() {
      var playerType;
      playerType = this.model.isDealer ? 'dealer' : 'player';
      this.$el.addClass(playerType);
      return this.model.on('change:chips', this.render, this);
    };

    PlayerView.prototype.template = _.template('<h2>Name: <%= name %> <% if (!isDealer) { %> Chips: <span class="chips"> <%= chips %> </span> <% } %></h2>');

    PlayerView.prototype.render = function() {
      var handView;
      this.$el.html(this.template(this.model.attributes));
      handView = new HandView({
        collection: this.model.get('hand')
      });
      this.$el.append(handView.render());
      return this.$el;
    };

    return PlayerView;

  })(Backbone.View);

}).call(this);

/*
//@ sourceMappingURL=PlayerView.map
*/
