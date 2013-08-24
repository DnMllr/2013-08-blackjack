class window.Player extends Backbone.Model
  initialize: (params) ->
    @set 'chips', 0
    @set 'name', params.name
    @set 'isDealer', params.isDealer
    @set 'done', false
    @set 'busted', false
    @set 'hand', new Hand()
    @listenTo (@get 'hand'), 'busted', => (@set 'busted', true)
    @listenTo (@get 'hand'), 'done', => (@set 'done', true)

  hit: -> @trigger 'I_want_to_hit', @
  stand: -> @trigger 'I_want_to_stand', @