class window.AppView extends Backbone.View

  events:
    "click .hit-button": ->
      @model.get('playerHand').hit()
      @model.get('dealerHand').hit()
    "click .stand-button": ->
      @model.get('playerHand').stand()
      @model.get('dealerHand').hit()

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    (@model.get 'players').each (player) =>
      container = if player.get 'isDealer' then '.dealer-hand-container' else '.player-hand-container'
      playerView = new PlayerView {model: player}
      @$el.append $('<div class =#{container} />').html playerView.render()
      @$el