db = require('./database')()
cb = (err,results,fields) ->
    console.log(results)
db.query("insert into users (username,password) values ('reedo','passwordo')")
db.query("select * from users",cb)
