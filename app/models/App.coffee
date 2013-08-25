class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', new Deck()
    players = new Players()
    human = new Player {name: 'player', isDealer: false}
    dealer = new Player {name: 'dealer', isDealer: true}
    @set 'dealer', dealer
    players.add [human, dealer]
    players.each (player) => @giveCards player
    @set 'currentPlayer', players.first()
    @set 'players', players

    @listenTo (@get 'players'), 'I_want_to_hit', (player) =>
      @addCardToPlayer(player)
      @nextTurn()

    @listenTo (@get 'players'), 'I_want_to_stand', (player) =>
      player.set 'done', true
      @nextTurn()

  newRound: ->
    @trigger 'newRound', @
    @set 'deck', new Deck()
    (@get 'players').each (player) =>
      player.set "done", false
      player.set "busted", false
      @giveCards player
    @set 'currentPlayer', (@get 'players').first()

  giveCards: (player) ->
    (player.get 'hand').reset()
    deck = @get 'deck'
    (player.get 'hand').add(deck.pop())
    (player.get 'hand').add(deck.pop())
    if player.get 'isDealer'
      (player.get 'hand').at(0).flip()

  addCardToPlayer: (player) -> (@get 'deck').hitPlayer player

  chooseDealerAction: ->
    scores = ((@get 'currentPlayer').get 'hand').actualScores()
    score = _.max (score for score in scores when score < 22)
    if score < 17
      (@get 'currentPlayer').hit()
    else
      (@get 'currentPlayer').stand()

  nextTurn: ->
    index = (@get 'players').models.indexOf(@get 'currentPlayer')
    @set 'currentPlayer', (@get 'players').at(index+1) or (@get 'players').first()
    if (@get 'currentPlayer').get 'done'
      everyoneIsDone = (@get 'players').all (player) -> player.get 'done'
      if everyoneIsDone
        alert 'GAME ENDED MUTHAFUCKAS'
        @findWinners()
        @
      else
        @nextTurn()
    else
      if (@get 'currentPlayer').get 'isDealer'
        @chooseDealerAction()

  findWinners: ->
    winners = []
    losers = []
    dealer = @get 'dealer'
    dealerScores = (score for score in (dealer.get 'hand').actualScores() when score < 22)
    scoreToBeat = if dealerScores.length then _.max dealerScores else 22
    if scoreToBeat > 21
      for player in @get 'players'
        winners.push player unless (player is dealer) or (player.get 'busted')
    else
      (@get 'players').each (player) =>
        if not player.get 'busted'
          legitScores = (score for score in (player.get 'hand').actualScores() when score < 22)
          bestScore = if legitScores.length then (_.max legitScores) else 0
          if bestScore > scoreToBeat
            #dealer always wins ties
            winners.push player
          else
            losers.push player
        else
          losers.push player
    winners.length is 0 and winners.push dealer
    for winner in winners
      winner.set 'chips', ((winner.get 'chips') + winner.get 'currentBet')
    for loser in losers
      loser.set 'chips', ((loser.get 'chips') - loser.get 'currentBet')
    @newRound()
