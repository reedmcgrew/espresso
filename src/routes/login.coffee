###
 GET login page.
###

module.exports = (req, res) ->
    res.render('login', { error: "", title: settings.app_title})
