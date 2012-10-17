fs = require 'fs'
gpio = require 'rpi-gpio'
twitter = require 'ntwitter'
credentials = require './credentials.json'

users = [874569288,8953122]

l =
  red: gpio.setup 14
  yellow: gpio.setup 15
  green: gpio.setup 18

t = new twitter(
  consumer_key: credentials.consumer_key
  consumer_secret: credentials.consumer_secret
  access_token_key: credentials.access_token_key
  access_token_secret: credentials.access_token_secret
)

t.stream 'statuses/filter', { follow: users }, (stream) ->
  stream.on 'data', (tweet) ->
    if tweet.user.id in users
      [lying,maybe,truthing] = (regex.test tweet.text for regex in [/false/i,/maybe/i,/true/i])

      if lying or maybe or truthing
        console.log tweet.text

        gpio.write l.red, +lying
        gpio.write l.yellow, +maybe
        gpio.write l.green, +truthing

        t.retweetStatus tweet.id, ->