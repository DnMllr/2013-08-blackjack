class window.HandView extends Backbone.View

  className: 'hand'

  initialize: ->
    @collection.on 'add remove change', => @render()
    @render()

  render: ->
    @$el.children().detach()
    $(@$el.html '<span class="score"></span>').text @collection.scores()[0]
    @$el.append @collection.map (card) ->
      cardView = new CardView(model: card)
      cardView.$el
    @$el
