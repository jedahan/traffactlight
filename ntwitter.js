var twitter = require('ntwitter');
var credentials = require('./consumer.json');
var fs = require('fs');

var t = new twitter({
  consumer_key: credentials.consumer_key,
  consumer_secret: credentials.consumer_secret,
  access_token_key: credentials.access_token_key,
  access_token_secret: credentials.access_token_secret
});

t.stream(
  'statuses/filter',
  { follow: [874569288,8953122] },
  function(stream) {
    stream.on('data', function(tweet) {
      console.log(tweet.text);
      
      if(tweet.text.match("True") > -1) {
        fs.writeFileSync("/sys/class/gpio/gpio14/value", "1");
      } else {
        fs.writeFileSync("/sys/class/gpio/gpio14/value", "0");
      }
      if(tweet.text.indexOf("aybe") > -1) {
        fs.writeFileSync("/sys/class/gpio/gpio15/value", "1");
      } else {
        fs.writeFileSync("/sys/class/gpio/gpio15/value", "0");
      }
      if(tweet.text.match("False") > -1) {
        fs.writeFileSync("/sys/class/gpio/gpio18/value", "1");
      } else {
        fs.writeFileSync("/sys/class/gpio/gpio18/value", "0");
      }
    });
  }
);