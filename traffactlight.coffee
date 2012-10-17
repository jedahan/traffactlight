fs = require 'fs'
twitter = require 'ntwitter'
credentials = require './credentials.json'

users = [874569288,8953122]

l = red: 14, yellow: 15, green: 18
l[color] = "/sys/class/gpio/gpio#{pin}/value" for color,pin of l

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

        fs.writeFileSync l.red, +lying
        fs.writeFileSync l.yellow, +maybe
        fs.writeFileSync l.green, +truthing

        t.retweetStatus tweet.id, ->