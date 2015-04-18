express = require('express')
bodyParser = require('body-parser')
botlogic = require('./botlogic')
app = express()
port = process.env.PORT or 3000
require 'coffee-script/register'
# body parser middleware
app.use bodyParser.urlencoded(extended: true)
# test route
app.get '/', (req, res) ->
  res.status(200).send 'Hello world!'
  return
#app.post('/scram', botlogic);
# error handler
app.use (err, req, res, next) ->
  console.error err.stack
  res.status(400).send err.message
  return
app.listen port, ->
  console.log 'Slack bot listening on port ' + port
  return