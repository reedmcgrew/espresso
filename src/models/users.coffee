{EventEmitter} = require 'events'
db = require('./database')()

#User Model
class exports.User extends EventEmitter
    constructor: (@username,@password=null,@role=null) ->
        @db = require('./database')()

    save: () ->
        announce_save = () =>
            @emit 'save'
        @db.query("insert ignore into users (username,password,role) 
         values ('#{@username}','#{@password}','#{@role}')", announce_save)

    auth: (password) ->
        @password is password


#User Model Utilities
exports.create = (username,password,role) ->
    user = new exports.User(username,password,role)
    user

exports.find = (username, event_catcher) ->
    announce_find = (err,results,field) =>
        if err
            event_catcher.emit 'error', err
        else if results.length >= 1
            result = results[0]
            user = new exports.User(result.username,result.password,result.role)
            event_catcher.emit 'find', user
        else
            event_catcher.emit 'find', null

    db.query("select * from users where username='#{username}'",announce_find)

