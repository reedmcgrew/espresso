###
    Handle event from generator
###
eslocators = require('../models/eslocators')
request = require('request')

module.exports = (req, res) ->
    console.log(req.body)
    #Validate Form Input
    if !req.body.pickup_by? or req.body.pickup_by is ""
        encoded_message = encodeURIComponent("Please Enter a Pickup Time.")
        res.redirect("/welcome/#{encoded_message}")
    else if !req.body.shop_address? or req.body.shop_address is ""
        encoded_message = encodeURIComponent("Please Enter the Flower Shop's Address")
        res.redirect("/welcome/#{encoded_message}")
    else if !req.body.customer_address? or req.body.customer_address is ""
        message = encodeURIComponent("Please Enter the Customer's Address")
        res.redirect("/welcome/#{message}")
    else
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
                requests_made = 0
                rec_request = () =>
                    if requests_made < results.length
                        opts.url = results[requests_made].esl
                        requests_made = requests_made + 1
                        request(opts, rec_request)
                    else
                        message = encodeURIComponent("Successfully notified #{requests_made} drivers of your request.")
                        res.redirect("/welcome/#{message}")
                #initiate requests sequence
                rec_request()
        #list the event signal locators and sent the event to them
        eslocators.list(callback)

