var twitter = require('ntwitter');
var credentials = require('./consumer.json');
var gpio = require("gpio");

var t = new twitter({
  consumer_key: credentials.consumer_key,
  consumer_secret: credentials.consumer_secret,
  access_token_key: credentials.access_token_key,
  access_token_secret: credentials.access_token_secret
});

var red = gpio.export(14, {direction: 'out'});
var yellow = gpio.export(15,{direction: 'out'});
var green = gpio.export(18,{direction: 'out'});

t.stream(
  'statuses/filter',
  { follow: [874569288,8953122] },
  function(stream) {
    stream.on('data', function(tweet) {
      console.log(tweet.text);
      
      if(tweet.text.match("True") > -1) {
        green.set();
      } else {
        green.reset();
      }
      if(tweet.text.indexOf("aybe") > -1) {
        yellow.set();
      } else {
        yellow.reset();
      }
      if(tweet.text.match("False") > -1) {
        red.set();
      } else {
        red.reset();
      }
    });
  }
);