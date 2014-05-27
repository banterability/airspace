redis = require 'redis'

class RedisClient
  constructor: ->
    @client = redis.createClient()

  getStatus: (airport) ->
    key = @buildKey airport
    @client.lrange key, 0, -1, (err, reply) ->
      console.log "reply", reply

  setStatus: (airport, delayed) ->
    key = @buildKey airport
    @client.lpush key, delayed

  buildKey: (airport) ->
    "airspace:v1:#{airport}:status"

module.exports = RedisClient
