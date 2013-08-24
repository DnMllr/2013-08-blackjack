class window.Player extends Backbone.Model
  initialize: (params) ->
    @set 'chips', 0
    @set 'name', params.name
    @set 'isDealer', params.isDealer

  hit: -> @trigger 'I_want_to_hit', @