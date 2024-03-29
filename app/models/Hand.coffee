class window.Hand extends Backbone.Collection

  model: Card

  initialize: (array) ->
    @on 'add', ->
      minScore = _.min @actualScores()
      console.log 'Minscore ' + minScore
      if minScore > 21
        @trigger 'done', @
        @trigger 'busted', @
      21 in @actualScores and @trigger 'done', @

  actualScores: ->
    hasAce = @reduce (memo, card) ->
      memo or card.get('value') is 1
    , false
    score = @reduce (score, card) ->
      score + card.get('value')
    , 0
    if hasAce then [score, score + 10] else [score]

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