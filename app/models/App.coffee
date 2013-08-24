#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', new Deck()
    players = new Players()
    human = new Player {name: 'player', isDealer: false}
    #human2 = new Player {name: 'dan', isDealer: false}
    #human3 = new Player {name: 'brian', isDealer: false}
    dealer = new Player {name: 'dealer', isDealer: true}
    @set 'dealer', dealer
    players.add [human, dealer]#, human2, human3]
    players.each (player) => @giveCards player
    @set 'winners', []
    @set 'losers', []

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
        @winnerTester()
        @
      else
        @nextTurn()
    else
      if (@get 'currentPlayer').get 'isDealer'
        (@get 'currentPlayer').stand()

  winnerTester: ->
    dealer = @get 'dealer'
    maxDealerScore = _.max (dealer.get 'hand').actualScores()
    scoreToBeat = if maxDealerScore < 22 then maxDealerScore else _.min (dealer.get 'hand').actualScores()
    if scoreToBeat > 21
      (@get 'players').each (player) =>
        (@get 'winners').push player unless (player is dealer or player.get 'busted')
    else
      (@get 'players').each (player) =>
        unless player.get 'busted'
          potentialScores = (player.get 'hand').actualScores()
          legitScores = []
          for score in potentialScores
            if score < 22
              legitScores.push score
          bestScore = _.max legitScores
          if bestScore > scoreToBeat
            (@get 'winners').push player
      (@get 'winners').length is 0 and (@get 'winners').push dealer
