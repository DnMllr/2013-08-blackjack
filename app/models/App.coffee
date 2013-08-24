class window.App extends Backbone.Model

  initialize: ->
    @set 'winners', []
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

  giveCards: (player) ->
    deck = @get 'deck'
    (player.get 'hand').add(deck.pop())
    (player.get 'hand').add(deck.pop())
    if player.get 'isDealer'
      (player.get 'hand').at(0).flip()

  addCardToPlayer: (player) -> (@get 'deck').hitPlayer player

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
        (@get 'currentPlayer').stand()

  findWinners: ->
    winners = []
    dealer = @get 'dealer'
    dealerScores = (score for score in (dealer.get 'hand').actualScores() when score < 22)
    scoreToBeat = if dealerScores.length then _.max dealerScores else 22
    if scoreToBeat > 21
      for player in @get 'players'
        winners.push player unless (player is dealer) or (player.get 'busted')
    else
      (@get 'players').each (player) =>
        unless player.get 'busted'
          legitScores = (score for score in (player.get 'hand').actualScores() when score < 22)
          bestScore = if legitScores.length then (_.max legitScores) else 0
          if bestScore > scoreToBeat
            #dealer always wins ties
            winners.push player
    winners.length is 0 and winners.push dealer
    @set 'winners', winners
    console.log (winner.get 'name' for winner in winners)
