###
 Get Auth Token.
###

users = require('../models/users')
settings = require('../settings')
{EventEmitter} = require 'events'

auth_error_message = encodeURIComponent("The username and password you provided are invalid.")

module.exports = (req, res) ->
    if req.body.user
        username = req.body.user.username
        password = req.body.user.password
        find_listener = new EventEmitter
        find_callback = (user) =>
            if user? and user.password is password
                flat_user =
                    role: user.role
                    username: user.username
                    
                #Set session
                req.session.user = flat_user

                #Pass to welcome page
                res.redirect('/welcome')
            else
                #Pass back to login with error
                res.redirect("/login/#{auth_error_message}")

        find_listener.on 'find', find_callback
        users.find(username,find_listener)
    else
        res.redirect("/login/#{auth_error_message}")
