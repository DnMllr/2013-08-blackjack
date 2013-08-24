// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.AppView = (function(_super) {
    __extends(AppView, _super);

    function AppView() {
      _ref = AppView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    AppView.prototype.events = {
      "click .hit-button": function() {
        return this.model.get('currentPlayer').hit();
      },
      "click .stand-button": function() {
        return this.model.get('currentPlayer').stand();
      }
    };

    AppView.prototype.initialize = function() {
      return this.render();
    };

    AppView.prototype.render = function() {
      var _this = this;
      this.$el.children().detach();
      this.$el.append($('<button class="hit-button">Hit</button> <button class="stand-button">Stand</button>'));
      return (this.model.get('players')).each(function(player) {
        var container, playerView;
        container = (player.get('isDealer') ? '.deal' : '.play') + 'er-hand-container';
        playerView = new PlayerView({
          model: player
        });
        _this.$el.append($("<div class = " + container + " />").html(playerView.render()));
        return _this.$el;
      });
    };

    return AppView;

  })(Backbone.View);

}).call(this);

/*
//@ sourceMappingURL=AppView.map
*/