twitter = require 'ntwitter'
credentials = require './credentials.json'
fs = require 'fs'

t = new twitter(
  consumer_key: credentials.consumer_key
  consumer_secret: credentials.consumer_secret
  access_token_key: credentials.access_token_key
  access_token_secret: credentials.access_token_secret
)

light =
  red: "/sys/class/gpio/gpio14/value"
  yellow: "/sys/class/gpio/gpio15/value"
  green: "/sys/class/gpio/gpio18/value"

t.stream "statuses/filter",
  follow: [874569288, 8953122]
, (stream) ->
  stream.on "data", (tweet) ->
    if tweet.user.id is 8953122
      console.log tweet.text
      fs.writeFileSync light.green, tweet.text.match("True") > -1
      fs.writeFileSync light.red, tweet.text.match("False") > -1
      fs.writeFileSync light.yellow, tweet.text.match("Maybe") > -1