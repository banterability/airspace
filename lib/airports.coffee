async = require 'async'
fs = require 'fs'
GroundStop = require 'ground-stop'

AIRPORTS = JSON.parse fs.readFileSync './data/airports.json', encoding: 'utf-8'

presentStatus = (airport, cb) ->
  code = airport.code
  GroundStop.fetch {airport: code}, (err, status) ->
    return cb err, {} if err
    {name, lat, lng, delay} = status
    cb err, {code, delay, name, lat, lng}

fetchStatus = (cb) ->
  async.map AIRPORTS, presentStatus, (err, results) ->
    cb err, results

module.exports = fetchStatus