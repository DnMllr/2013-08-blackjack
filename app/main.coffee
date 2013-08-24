new AppView(model: new App()).$el.appendTo 'body'



#TODO: listento this.model.on(change:currentplayer),
#       and when it changes, see if it's the dealer
#       if so, make the dealer hit

#TODOL listen to this.model.on('finished')