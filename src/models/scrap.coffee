users = require './users'
{EventEmitter} = require 'events'





user = users.create('foo','bar')
user.on 'save', () ->
    console.log('we got here')
    event = new EventEmitter
    event.on 'find', (fuser) ->
        console.log('we found it|' + fuser.username + "|" + fuser.password)
    users.find('foo',event)
user.save()
