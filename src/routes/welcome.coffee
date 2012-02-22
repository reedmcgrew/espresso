
###
 GET home page.
###

settings = require '../settings'

module.exports = (req, res) ->
    error = if req.params.error? then decodeURIComponent(req.params.error) else ""
    user = req.session.user
    res.render('welcome', { error: error, title: settings.app_title, user: user })
