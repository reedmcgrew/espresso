###
 GET Signup page.
###
settings = require '../settings'

module.exports = (req, res) ->
    error = if req.params.error? then decodeURIComponent(req.params.error) else ""
    res.render('signup', { error: error, title: settings.app_title })
