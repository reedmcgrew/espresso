{EventEmitter} = require 'events'
db = require('./database')()
class exports.User extends EventEmitter
    constructor: (@username,@password=null) ->
        @db = require('./database')()

    save: () ->
        announce_save = () =>
            @emit 'save'
        @db.query("insert ignore into users (username,password) 
         values ('#{@username}','#{@password}')", announce_save)

    auth: (password) ->
        @password is password

exports.create = (username,password) ->
    user = new exports.User(username,password)
    user

exports.find = (username, event_catcher) ->
    announce_find = (err,results,field) =>
        throw err if err
        if results.length >= 1
            result = results[0]
            user = new exports.User(result.username,result.password)
            event_catcher.emit 'find', user
        else
            event_catcher.emit 'find', null

    db.query("select * from users where username='#{username}'",announce_find)

