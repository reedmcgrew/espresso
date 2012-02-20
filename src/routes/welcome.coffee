
###
 GET home page.
###

settings = require '../settings'

module.exports = (req, res) ->
    user = req.session.user
    res.render('welcome', { title: settings.app_title, user: user })
