###
 GET login page.
###
settings = require '../settings'

module.exports = (req, res) ->
    if req.session.user?
        res.redirect('/welcome')
    else
        error = if req.params.error? then decodeURIComponent(req.params.error) else ""
        res.render('login', { error: error, title: settings.app_title})
