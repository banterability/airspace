fs = require 'fs'
request = require 'request'
{pick, sortBy} = require 'underscore'

# 20 busiest in US, based on http://en.wikipedia.org/wiki/List_of_the_busiest_airports_in_the_United_States
AIRPORT_CODES = ['ATL', 'ORD', 'LAX', 'MIA', 'DFW', 'DEN', 'JFK', 'SFO', 'CLT', 'LAS', 'PHX', 'IAH', 'MCO', 'EWR', 'SEA', 'MSP', 'DTW', 'PHL', 'BOS', 'LGA']

requestOptions =
  url: "http://airports.pidgets.com/v1/airports/#{AIRPORT_CODES.join(',')}"
  qs:
    format: 'json'
  json: true

request requestOptions, (err, body, data) ->
  return throw err if err
  airportData = data.map (result) ->
    fields = pick result, 'code', 'name', 'lat', 'lon'
    fields.rank = AIRPORT_CODES.indexOf(fields.code) + 1
    fields

  fs.writeFileSync('./data/airports.json', JSON.stringify(
    sortBy(airportData, 'rank'), null, "  ")
  )

console.log 'done.'
