fs = require 'fs'
request = require 'request'
{pick} = require 'underscore'

# 20 busiest in US, based on http://en.wikipedia.org/wiki/List_of_the_busiest_airports_in_the_United_States
AIRPORTS = ['ATL', 'ORD', 'LAX', 'MIA', 'DFW', 'DEN', 'JFK', 'SFO', 'CLT', 'LAS', 'PHX', 'IAH', 'MCO', 'EWR', 'SEA', 'MSP', 'DTW', 'PHL', 'BOS', 'LGA']

airportList = AIRPORTS.map((airport) -> return airport.toLowerCase()).join(",")

requestOptions =
  url: "http://airports.pidgets.com/v1/airports/#{airportList}"
  qs:
    format: 'json'
  json: true

request requestOptions, (err, body, data) ->
  return throw err if err
  fs.writeFileSync('./data/airports.json', JSON.stringify(data.map((result) -> pick result, 'code', 'name', 'lat', 'lon'), null, "  "))

console.log 'done.'
