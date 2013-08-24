class window.AppView extends Backbone.View

  events:
    "click .hit-button": ->
      @model.get('currentPlayer').hit()
    "click .stand-button": ->
      @model.get('currentPlayer').stand()
    "click .bet10-button": ->
      @$('.better').attr('disabled', true)
      @model.get('currentPlayer').bet(10)
    "click .bet20-button": ->
      @$('.better').attr('disabled', true)
      @model.get('currentPlayer').bet(20)
    "click .bet50-button": ->
      @$('.better').attr('disabled', true)
      @model.get('currentPlayer').bet(50)
    "click .bet100-button": ->
      @$('.better').attr('disabled', true)
      @model.get('currentPlayer').bet(100)

  initialize: ->
    @listenTo @model, 'newRound', => @reenableButtons()
    @render()

  reenableButtons: ->
    @$('.better').removeAttr('disabled')

  render: ->
    @$el.children().detach()
    @$el.append $('<button class="hit-button">Hit</button> <button class="stand-button">Stand</button>')
    @$el.append $('<button class="better bet10-button">Bet 10%</button>')
    @$el.append $('<button class="better bet20-button">Bet 20%</button>')
    @$el.append $('<button class="better bet50-button">Bet 50%</button>')
    @$el.append $('<button class="better bet100-button">Bet 100%</button>')
    (@model.get 'players').each (player) =>
      container = (if player.get 'isDealer' then '.deal' else '.play') + 'er-hand-container'
      playerView = new PlayerView {model: player}
      @$el.append $("<div class = #{ container } />").html playerView.render()
      @$el