async = require 'async'
fs = require 'fs'
GroundStop = require 'ground-stop'

AIRPORTS = JSON.parse fs.readFileSync './data/airports.json', encoding: 'utf-8'

presentStatus = (airport, cb) ->
  code = airport.code
  console.log "fetching #{code}..."
  GroundStop.fetch {airport: code}, (err, status) ->
    return cb err, {} if err
    cb err, {airport: code, delayed: status.delay}

async.map AIRPORTS, presentStatus, (err, results) ->
  console.log "err", err
  console.log "results", results
