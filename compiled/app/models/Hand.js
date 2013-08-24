// Generated by CoffeeScript 1.6.3
(function() {
  var _ref,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  window.Hand = (function(_super) {
    __extends(Hand, _super);

    function Hand() {
      _ref = Hand.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Hand.prototype.model = Card;

    Hand.prototype.initialize = function(array) {
      return this.on('add', function() {
        var minScore;
        minScore = _.min(this.actualScores());
        console.log('Minscore ' + minScore);
        if (minScore > 21) {
          this.trigger('done', this);
          this.trigger('busted', this);
        }
        return __indexOf.call(this.actualScores, 21) >= 0 && this.trigger('done', this);
      });
    };

    Hand.prototype.actualScores = function() {
      var hasAce, score;
      hasAce = this.reduce(function(memo, card) {
        return memo || card.get('value') === 1;
      }, false);
      score = this.reduce(function(score, card) {
        return score + card.get('value');
      }, 0);
      if (hasAce) {
        return [score, score + 10];
      } else {
        return [score];
      }
    };

    Hand.prototype.scores = function() {
      var hasAce, score;
      hasAce = this.reduce(function(memo, card) {
        return memo || card.get('value') === 1;
      }, false);
      score = this.reduce(function(score, card) {
        return score + (card.get('revealed') ? card.get('value') : 0);
      }, 0);
      if (hasAce) {
        return [score, score + 10];
      } else {
        return [score];
      }
    };

    return Hand;

  })(Backbone.Collection);

}).call(this);

/*
//@ sourceMappingURL=Hand.map
*/
