db = require('./database')()

exports.create = (esl,username,callback) ->
    db.query("insert ignore into eslocators (esl,username) values (?,?);",[esl,username],callback)
    undefined

exports.list = (callback) ->
    #Callback signature must be of the form: (err,results,field) =>
    ### if err
            event_catcher.emit 'error', err
        else if results.length >= 1
            result = results[0]
            user = new exports.User(result.username,result.password,result.role)
            event_catcher.emit 'find', user
        else
            event_catcher.emit 'find', null
    ###
    db.query("select * from eslocators;",callback)
    undefined

