express = require 'express'
fs = require 'fs'
fetchStatus = require './lib/airports'

app = express()

app.get '/', (req, res) ->
  page = fs.createReadStream 'views/index.html'
  page.on 'open', -> page.pipe(res)
  page.on 'error', (err) -> res.send 500

app.get '/status', (req, res) ->
  fetchStatus (err, response) ->
    return res.send 500 if err
    res.send {airports: response}

port = process.env.PORT || 5678
app.listen port, ->
  console.log "server up on #{port}…"
