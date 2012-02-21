###
 Create user account
###

users = require('../models/users')
settings = require('../settings')
{EventEmitter} = require 'events'

#Error messages
already_taken_error = encodeURIComponent("The username your provided is already taken.")
password_match_error = encodeURIComponent("Both password fields must match.")
no_type_error = encodeURIComponent("Please select an account type")

#Short-circuiting validator
override = false
validate = (condition,failure_url,res,message) =>
    if not condition and not override
        override = true
        res.redirect(failure_url+ "/#{message}")

#Route controller
module.exports = (req, res) ->
    if req.body.user
        back_url = '/signup'

        #make sure username isn't already taken
        username = req.body.user.username
        catch_find = new EventEmitter
        catch_find.on 'find', (user) ->
            validate(user is null, back_url, res, already_taken_error)

            #make sure passwords are the same
            password = req.body.user.password
            re_password = req.body.user.re_password
            validate(password is re_password, back_url, res, password_match_error)
        
            #make sure type has been selected
            type = req.body.user.role
            validate(type in settings.account_types, back_url, res, no_type_error)

            #create user
            new_user = users.create(username,password,type)
            new_user.on 'save', (user) ->
                if not override
                    res.redirect("/authenticate")
                ###authenticate
                flat_user =
                    role: user.role
                    username: user.username

                #Set session
                req.session.user = flat_user

                #Pass to welcome page
                res.redirect('/welcome')
                ###

            new_user.save()

        users.find(username,catch_find)
