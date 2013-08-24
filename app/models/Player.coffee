class window.Player extends Backbone.Model
  initialize: (params) ->
    @set 'chips', 0
    @set 'name', params.name
    @set 'isDealer', params.isDealer
    @set 'busted', false
    @set 'hand', new Hand()
    @listenTo (@get 'hand'), 'bust', => (@set 'busted', true)

  hit: -> @trigger 'I_want_to_hit', @