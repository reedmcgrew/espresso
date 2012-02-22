###
    Handle event from generator
###
module.exports = (req, res) ->
    domain = req.body._domain
    name = req.body._name

    console.log domain + ":" + name + " fired."
    res.end()
