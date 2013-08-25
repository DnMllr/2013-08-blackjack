// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  window.CardView = (function(_super) {
    __extends(CardView, _super);

    function CardView() {
      _ref = CardView.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    CardView.prototype.className = 'card';

    CardView.prototype.template = _.template('<%= rankName %> of <%= suitName %>');

    CardView.prototype.initialize = function() {
      var _this = this;
      this.model.on('change', function() {
        return _this.render;
      });
      return this.render();
    };

    CardView.prototype.render = function() {
      var rank;
      this.$el.children().detach().end().html;
      rank = this.model.get('rankName');
      console.log(this.model.get('suitName'));
      rank = typeof rank === !'number' ? rank.toString()[0] : rank;
      if (this.model.get('revealed')) {
        this.$el.html(Poker.getCardImage(140, (this.model.get('suitName')).toLowerCase(), rank));
      } else {
        this.$el.html(Poker.getBackImage(140, (this.model.get('suitName')).toLowerCase(), rank));
      }
      if (!this.model.get('revealed')) {
        return this.$el.addClass('covered');
      }
    };

    return CardView;

  })(Backbone.View);

}).call(this);

/*
//@ sourceMappingURL=CardView.map
*/
