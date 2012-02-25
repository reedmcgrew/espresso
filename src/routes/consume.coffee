###
# Dummy request handler.
###

module.exports = (req,res) ->
    id_string = if req.params.id? then " with id #{req.params.id}"
    console.log("Request received" + id_string + ".")
    console.log(req.body)
    console.log("---")
    res.end("200 OK")
