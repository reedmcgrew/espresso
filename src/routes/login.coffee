
###
 GET login page.
###

module.exports = (req, res) ->
    ###
    if req.session.token isnt null
        res.writeHead(303, { "location": settings.root_url + "home" })
        res.end()
    ###

    res.render('login', { title: 'Flower Delivery Service' })
