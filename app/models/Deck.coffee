class window.Deck extends Backbone.Collection

  model: Card

  initialize: ->
    @add _([1..52]).shuffle().map (number) ->
      new Card
        rank: number % 13
        suit: Math.floor(number / 13)

  dealPlayer: -> new Hand [ @pop(), @pop() ], @

  dealDealer: -> new Hand [ @pop().flip(), @pop() ], @, true
