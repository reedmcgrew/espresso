users = require './users'
async = require 'async'
{EventEmitter} = require 'events'

exports.testAcceptance = (test) ->
    num_assertions = 5
    test.expect(num_assertions)

    #Set up
    username = "rmcgrew"
    right_password = "pass"
    wrong_password = "wrongpass"
    role = "flower-shop"


    #Test saving and finding of users
    user = users.create(username,right_password,role)#username,right_password)
    user.on 'save', () ->
        catch_find = new EventEmitter
        catch_find.on 'find', (found_user) ->
            test.ok(found_user isnt null, "User #{username} was not found, but should have been.")
            test.ok(found_user.username is username, "[found_user.name] expected:#{username}, actual:#{found_user.username}")
            test.ok(found_user.role is role, "[found_user.role] expected:#{role}, actual:#{found_user.role}")
            test.ok(found_user.auth(wrong_password) isnt true,  "User #{username} authenticates with a bogus password.")
            test.ok(found_user.auth(right_password) is true, "User #{username} doesn't authenticate with the right password #{right_password}.")
            test.done()   # <------    The end point is here
        users.find(username,catch_find)

    user.save()
