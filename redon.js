var gpio = require("gpio");


var red = gpio.export(14, {
  direction: 'out',
  ready: function() {
    red.set();
  }
});