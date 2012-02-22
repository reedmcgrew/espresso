###
    Handle event from generator
###
eslocators = require('../models/eslocators')
error_back = (message,res) ->
    encoded_message = encodeURIComponent(message)
    res.redirect("/welcome/#{encoded_message}")
    
module.exports = (req, res) ->
    #Validate Form Input
    if !req.body.pickup_by
        error_back("Please Enter a Pickup Time.",res)
    
    if !req.body.shop_address
        error_back("Please Enter the flower shop's address",res)

    if !req.body.customer_address
        error_back("Please Enter the customer's address", res)
        message = encodeURIComponent("Please Enter the customer's address")
        res.redirect("/welcome/#{message}")

    

    #Generate Event
    req.body._domain = "rfq"
    req.body._name = "delivery_ready"
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

    #list the event signal locators and sent the event to them
    eslocators.list(callback)
