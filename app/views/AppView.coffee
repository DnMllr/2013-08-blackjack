class window.AppView extends Backbone.View

  events:
    "click .hit-button": ->
      @model.get('currentPlayer').hit()
    "click .stand-button": ->
      @model.get('playerHand').stand()
      @model.get('dealerHand').hit()

  initialize: -> @render()

  render: ->
    @$el.children().detach()
    @$el.append $('<button class="hit-button">Hit</button> <button class="stand-button">Stand</button>')
    (@model.get 'players').each (player) =>
      container = (if player.get 'isDealer' then '.deal' else '.play') + 'er-hand-container'
      playerView = new PlayerView {model: player}
      @$el.append $("<div class = #{ container } />").html playerView.render()
      @$el