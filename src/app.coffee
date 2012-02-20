###
Module dependencies.
###
express = require 'express'
global.routes = require './routes'
global.settings = require './settings'
global.models = require './models'

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

console.log("Binding Routes for #{settings.app_title}")

###
Routes
###
app.get('/', routes.index)
app.get('/login', routes.login)
app.post('/login', routes.authenticate)
app.post('/authenticate', routes.authenticate)
app.listen(80)
console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env)
