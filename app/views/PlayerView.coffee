class window.PlayerView extends Backbone.View

  initialize: ->
    playerType = if @model.isDealer then 'dealer' else 'player'
    @$el.addClass(playerType)

  template: _.template '<h2>Name: <%= name %> Chips: <span class="chips"> <%= chips %> </span></h2>'

  render: ->
    @$el.html @template @model.attributes
    handView = new HandView { collection: @model.get 'hand' }
    @$el.append handView.render()
    @$el
