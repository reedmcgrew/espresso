###
 GET login page.
###

module.exports = (req, res) ->
    user =
        name: 'empty'
        password: 'empty'
    if req.body.user?
        user.name = req.body.user.name
        user.password = req.body.user.password

    res.render('login', { title: 'Flower Delivery Service', user: user})
