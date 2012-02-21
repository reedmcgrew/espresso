###
 Create user account
###

users = require('../models/users')
settings = require('../settings')
{EventEmitter} = require 'events'

#Error messages
already_taken_error = encodeURIComponent("The username your provided is already taken.")
password_match_error = encodeURIComponent("Both password fields must match.")
password_blank_error = encodeURIComponent("Password may not be blank.")
no_type_error = encodeURIComponent("Please select an account type")



#Route controller
module.exports = (req, res) ->
    #Short-circuiting validator
    override = false
    validate = (condition,failure_url,res,message) =>
        if not condition and not override
            override = true
            res.redirect(failure_url+ "/#{message}")

    console.log "25"
    if req.body.user
        console.log "27" + override
        back_url = '/signup'

        #make sure username isn't already taken
        username = req.body.user.username
        catch_find = new EventEmitter
        catch_find.on 'find', (user) ->
            console.log "34" + override
            validate(user is null, back_url, res, already_taken_error)
            console.log "36" + override

            #make sure passwords are the same and not blank
            password = req.body.user.password
            re_password = req.body.user.re_password
            validate(password is re_password, back_url, res, password_match_error)
            console.log "38" + override
            validate(password isnt null and password isnt "", back_url, res, password_blank_error)
            console.log "40" + override

            #make sure type has been selected
            type = req.body.user.role
            console.log "48" + override
            validate(type in settings.account_types, back_url, res, no_type_error)
            console.log "50" + override

            #create user
            if not override
                console.log "54" + override
                new_user = users.create(username,password,type)
                console.log "56" + override
                new_user.on 'save', () ->
                    console.log "58" + override
                    #authenticate
                    flat_user =
                        role: new_user.role
                        username: new_user.username

                    #Set session
                    req.session.user = flat_user

                    #Pass to welcome page
                    res.redirect('/welcome')

                new_user.save()

        users.find(username,catch_find)
