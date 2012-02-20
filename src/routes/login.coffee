###
 GET login page.
###

module.exports = (req, res) ->
    console.log "Hitting Login Controller"
    res.render('login', { error: "", title: settings.app_title})
