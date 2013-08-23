class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array, @deck, @isDealer) ->

  hit: -> @add(@deck.pop()).last()

  #stand: -> let the dealer finish doing his thing
  #create Player models
  #each player has a score (cumulative), a hand, and some available actions
  #create a Game model
  #Game has players and a current Player
  #if currentplayer === human, then show the buttons and accept an action
  #if dealer, follow some strategy(KISS- always hit)
  #game has rounds/hands?
  #signal the end of a hand whenever both players are out of moves
  #out of moves = you stood, or you busted

  scores: ->
    # The scores are an array of potential scores.
    # Usually, that array contains one element. That is the only score.
    # when there is an ace, it offers you two scores - the original score, and score + 10.
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + if card.get('revealed') then card.get('value') else 0
    , 0
    if hasAce then [score, score + 10] else [score]
