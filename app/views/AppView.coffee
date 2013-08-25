class window.AppView extends Backbone.View

  events:
    "click .hit-button": ->
      @model.get('currentPlayer').hit()
    "click .stand-button": ->
      @model.get('currentPlayer').stand()
    "click .better": (event) ->
      @toggleButtons()
      @model.get('currentPlayer').bet($(event.currentTarget).data('amount'))

  initialize: ->
    @listenTo @model, 'newRound', => @toggleButtons()
    @render()

  toggleButtons: ->
    @$('button').each (index, button) ->
      button = $(button)
      if button.attr('disabled') then button.removeAttr('disabled') else button.attr('disabled', true)

  render: ->
    @$el.children().detach()
    @$el.append $('<button class="hit-button" disabled>Hit</button> <button class="stand-button" disabled>Stand</button>')
    @$el.append $('<button class="better bet10-button">Bet 10%</button>').data('amount', 10)
    @$el.append $('<button class="better bet20-button">Bet 20%</button>').data('amount', 20)
    @$el.append $('<button class="better bet50-button">Bet 50%</button>').data('amount', 50)
    @$el.append $('<button class="better bet100-button">Bet 100%</button>').data('amount', 100)
    (@model.get 'players').each (player) =>
      container = (if player.get 'isDealer' then '.deal' else '.play') + 'er-hand-container'
      playerView = new PlayerView {model: player}
      @$el.append $("<div class = #{ container } />").html playerView.render()
      @$el