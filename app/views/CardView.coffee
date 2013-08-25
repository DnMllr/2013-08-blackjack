class window.CardView extends Backbone.View

  className: 'card'

  template: _.template '<%= rankName %> of <%= suitName %>'

  initialize: ->
    @model.on 'change', => @render
    @render()

  render: ->
    @$el.children().detach().end().html
    rank = @model.get 'rankName'
    console.log((@model.get 'suitName'))
    rank = if typeof rank is not 'number' then rank.toString()[0] else rank
    if @model.get 'revealed'
      @$el.html(Poker.getCardImage(140, (@model.get 'suitName').toLowerCase(),rank))
    else
      @$el.html(Poker.getBackImage(140, (@model.get 'suitName').toLowerCase(),rank))
    @$el.addClass 'covered' unless @model.get 'revealed'
