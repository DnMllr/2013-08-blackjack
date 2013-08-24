new AppView(model: new App()).$el.appendTo 'body'



#TODO: listen to this.model.on('finished')

#TODO: players out here, since they remain constant thruout rounds (aka "Apps")
#TODO: rename App to game, or create new Game.js class and replace with contents of App
#TODO: when round is over, award winners, punish losers
#TODO: when round is over, 