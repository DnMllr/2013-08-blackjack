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

    AppView.prototype.template = _.template('\
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>\
    <div class="player-hand-container"></div>\
    <div class="dealer-hand-container"></div>\
  ');

    AppView.prototype.events = {
      "click .hit-button": function() {
        this.model.get('playerHand').hit();
        return this.model.get('dealerHand').hit();
      },
      "click .stand-button": function() {
        this.model.get('playerHand').stand();
        return this.model.get('dealerHand').hit();
      }
    };

    AppView.prototype.initialize = function() {
      return this.render();
    };

    AppView.prototype.render = function() {
      this.$el.children().detach();
      this.$el.html(this.template());
      this.$('.player-hand-container').html(new HandView({
        collection: this.model.get('playerHand')
      }).el);
      return this.$('.dealer-hand-container').html(new HandView({
        collection: this.model.get('dealerHand')
      }).el);
    };

    return AppView;

  })(Backbone.View);

}).call(this);

/*
//@ sourceMappingURL=AppView.map
*/
