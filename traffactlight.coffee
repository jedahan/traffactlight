fs = require 'fs'
twitter = require 'ntwitter'
credentials = require './credentials.json'

users = [874569288,8953122]

l =
  red: '/sys/class/gpio/gpio14/value'
  yellow: '/sys/class/gpio/gpio15/value'
  green: '/sys/class/gpio/gpio18/value'

t = new twitter(
  consumer_key: credentials.consumer_key
  consumer_secret: credentials.consumer_secret
  access_token_key: credentials.access_token_key
  access_token_secret: credentials.access_token_secret
)

t.stream 'statuses/filter', { follow: users }, (stream) ->
  stream.on 'data', (tweet) ->
    if tweet.user.id in users
      fs.writeFileSync l.red, +(/false/i.test tweet.text)
      fs.writeFileSync l.yellow, +(/maybe/i.test tweet.text)
      fs.writeFileSync l.green, +(/true/i.test tweet.text)