mysql = require('mysql')
#Options
db_user = 'foursquare_user'
db_pass = 'silly pass'
db_database = 'user_data'
options =
  user: db_user
  password: db_pass
  database: db_database


db = null
module.exports = ->
  db = mysql.createClient(options) if db is null
  db
