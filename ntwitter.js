var twitter = require('ntwitter');
var credentials = require('./consumer.json');
var gpio = require("gpio");

var t = new twitter({
    consumer_key: credentials.consumer_key,
    consumer_secret: credentials.consumer_secret,
    access_token_key: credentials.access_token_key,
    access_token_secret: credentials.access_token_secret
});

var red = gpio.export(14, { 
  direction: 'out',
  ready: function() {
    red.setDirection("out");
  }
});
var yellow = gpio.export(15,{
  direction: 'out',
  ready: function() {
    yellow.setDirection("out");
  }
});
var green = gpio.export(18,{
  direction: 'out',
  ready: function() {
    green.setDirection("out");
  }
});

t.stream(
    'statuses/filter',
    { follow: [874569288,8953122] },
    function(stream) {
        stream.on('data', function(tweet) {
            console.log(tweet.text);
            var maybe = tweet.text.indexOf("aybe") > -1;
            var truefact = tweet.text.match("True") > -1;
            var falsefact = tweet.text.match("False") > -1;
            
            if(truefact) {
              green.set(1);
            } else {
              green.reset();
            }
            if(maybe) {
              yellow.set(1);
            } else {
              yellow.reset();
            }
            if(falsefact) {
              red.set(1);
            } else {
              red.reset();
            }
            
            console.log(truefact,maybe,falsefact);
        });
    }
);