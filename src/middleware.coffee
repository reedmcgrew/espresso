exports.force_login = (req,res,next) ->
    if req.session.user?
        next()
    else
        res.redirect('/login')

exports.skip_if_authorized = (req,res,next) ->
    if req.session.user?
        res.redirect('/welcome')
    else
        next()
