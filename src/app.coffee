###
Module dependencies.
###
express = require 'express'
routes = require './routes'
settings = require './settings'

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
middleware = require './middleware'
authorize = middleware.force_login
skip_if_authorized = middleware.skip_if_authorized

#authentication
app.get('/login/:error', skip_if_authorized, routes.login)
app.get('/login', skip_if_authorized, routes.login)
app.post('/authenticate', skip_if_authorized, routes.authenticate)
app.get('/signup/:error', skip_if_authorized, routes.signup)
app.get('/signup', skip_if_authorized, routes.signup)
app.post('/create', skip_if_authorized, routes.create)

#app pages
app.get('/welcome', authorize, routes.welcome)
app.get('/welcome/:error', authorize, routes.welcome)

#consumer
app.post('/consume', routes.consume)
app.post('/consume/:id', routes.consume)

#generator
app.post('/events', authorize, routes.recv_event)
app.post('/events::port', authorize, routes.recv_event)
app.post('/eslocators', authorize, routes.eslocators)
app.post('/eslocators::port', authorize, routes.eslocators)
app.post('/gen_event', authorize, routes.gen_event)

#wild card
#app.all('/:anything?', skip_if_authorized, routes.login)

###
Start Server
###
app.listen(80)
console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env)
