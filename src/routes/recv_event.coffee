###
    Handle event from generator
###
eslocators = require('../models/eslocators')
module.exports = (req, res) ->
    if not req.body._domain?
        throw "_domain field MUST be set and is not!"
    if not req.body._domain?
        throw "_name field MUST be set and is not!"

    opts =
        method: "POST"
        headers:
            "Content-Type":"application/json"
        body: JSON.stringify(req.body)

    callback = (err,results,field) =>
        if err
            throw err
        else
            #recursively make all calls to enforce sequence
            idx = 0
            rec_request = () =>
                if requests_made < results.length
                    opts.url = results[idx].esl
                    idx = idx + 1
                    request(opts, rec_request)
                else
                    message = encodeURIComponent("Successfully notified #{idx} drivers of your request.")
                    res.redirect("/welcome/#{message}")

            #initiate requests sequence
            rec_request

    eslocators.list(callback)
