#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', new Deck()
    players = new Players()
    human = new Player {name: 'player', isDealer: false}
    #human2 = new Player {name: 'dan', isDealer: false}
    #human3 = new Player {name: 'brian', isDealer: false}
    dealer = new Player {name: 'dealer', isDealer: true}
    players.add [human, dealer]#, human2, human3]
    players.each (player) => @giveCards player

    @set 'currentPlayer', players.first()
    @set 'players', players

    @listenTo (@get 'players'), 'I_want_to_hit', (player) =>
      @addCardToPlayer(player)
      @nextTurn(player)

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
    if (@get 'currentPlayer').get 'busted'
      everyoneIsBusted = (@get 'players').all (player) -> player.get 'busted'
      if everyoneIsBusted
        alert 'GAME ENDED MUTHAFUCKAS'
        @
      else
        @nextTurn()
        #index = (@get 'players').models.indexOf(@get 'currentPlayer')
        #@set 'currentPlayer', (@get 'players').at(index+1) or (@get 'players').first()
    else
      if (@get 'currentPlayer').get 'isDealer'
        (@get 'currentPlayer').hit()