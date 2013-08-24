#todo: refactor to have a game beneath the outer blackjack model
class window.App extends Backbone.Model

  initialize: ->
    @set 'deck', new Deck()
    players = new Players()
    human = new Player {name: 'player', isDealer: false}
    dealer = new Player {name: 'dealer', isDealer: true}
    players.add [human, dealer]
    players.each (player) => @giveCards player
    @set 'currentPlayer', players.first()
    @set 'players', players

  giveCards: (player) ->
    deck = @get 'deck'
    hand = new Hand [deck.pop(), deck.pop()]
    player.set 'hand', hand
