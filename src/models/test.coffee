users = require './users'
async = require 'async'
{EventEmitter} = require 'events'

exports.testAcceptance = (test) ->
    num_assertions = 4
    test.expect(num_assertions)

    #Set up
    username = "rmcgrew"
    right_password = "pass"
    wrong_password = "wrongpass"


    #Test saving and finding of users
    user = users.create(username,right_password)#username,right_password)
    user.on 'save', () ->
        catch_find = new EventEmitter
        catch_find.on 'find', (found_user) ->
            test.ok(found_user isnt null, "User #{username} was not found, but should have been.")
            test.ok(found_user.username is username, "[found_user.name] expected:#{username}, actual:#{found_user.username}")
            test.ok(found_user.auth(wrong_password) isnt true,  "User #{username} authenticates with a bogus password.")
            test.ok(found_user.auth(right_password) is true, "User #{username} doesn't authenticate with the right password #{right_password}.")
            test.done()   # <------    The end point is here
        users.find(username,catch_find)

    user.save()

    ###
    #test pre-login foursquare
    

    #log-in user with wrong password
    wrong_auth = user.authenticate(wrong_password)
    test.ok(wrong_auth isnt true, "Authenticate response came back as #{wrong_auth}; should be false")
    test.ok(user.logged_in() isnt true, login_error)

    #log-in user with right password
    right_auth = user.authenticate(right_password)
    test.ok(right_auth,"Authenticate response came back as #{right_auth}; should be true.")
    login_result = user.logged_in()
    test.ok(login_result is true, "[user.logged_in()] expected: true, actual: #{login_result}")

    #test post-login foursquare    

    #log user out

   
    #get checkins
    #get checkins (should only be one
    #clean up foursquare cookie and user
    ###
        
    
