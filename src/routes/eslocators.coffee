###
    Handle event from generator
###
eslocators = require('../models/eslocators')
module.exports = (req, res) ->
    esl = req.body.esl
    eslocators.create(esl, req.session.user.username, () ->
        message = encodeURIComponent("Successfully registered new ESL: #{req.body.esl}")
        res.redirect("/welcome/#{message}")
    )
