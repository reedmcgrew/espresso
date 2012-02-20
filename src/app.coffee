###
Module dependencies.
###
express = require 'express'
routes = require './routes'
global.settings = require './settings'

app = express.createServer()
module.exports = app

###
Configuration
###
app.configure(() ->
  app.set('views', __dirname + '/views')
  app.set('view engine', 'jade')
  app.use(express.logger())
  app.use(express.bodyParser())
  app.use(express.cookieParser())
  app.use(express.session({secret: settings.session_secret}))
  app.use(express.methodOverride())
  app.use(app.router)
  app.use(express.static(__dirname + '/public'))
)

app.configure('development', () ->
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }))
)

app.configure('production', () ->
  app.use(express.errorHandler())
)

###
Routes
###
app.get('/', routes.index)

app.listen(80)
console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env)
