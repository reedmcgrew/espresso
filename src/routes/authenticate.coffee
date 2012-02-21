###
 Get Auth Token.
###

users = require('../models/users')
settings = require('../settings')
{EventEmitter} = require 'events'
auth_error_message = encodeURIComponent("The username and password your provided were not found.")
error_template_vars =
    error: auth_error_message
    title: settings.app_title

module.exports = (req, res) ->
    console.log("Hitting authenticate controller")
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
                console.log("GOING TO WELCOME PAGE")
                res.redirect('/welcome')
            else
                console.log("GOING BACK TO LOGIN 29")
                #Pass back to login with error
                res.redirect("/login/#{auth_error_message}")

        find_listener.on 'find', find_callback
        users.find(username,find_listener)
    else
        console.log("GOING BACK TO LOGIN 33")
        res.render('login', error_template_vars)
