mysql = require('mysql')
settings = require('../settings')
#Options
options =
  user: settings.db_user
  password: settings.db_pass
  database: settings.db_database


db = null
module.exports = ->
  db = mysql.createClient(options) if db is null
  db
