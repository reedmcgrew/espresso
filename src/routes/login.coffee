###
 GET login page.
###

module.exports = (req, res) ->
    error = if req.params.error? then decodeURIComponent(req.params.error) else ""
    res.render('login', { error: error, title: settings.app_title})
