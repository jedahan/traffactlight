var gpio = require("gpio");

for(var i=10; i<16; i++) {
  var red = gpio.export(i, {
    direction: 'out',
    ready: function() {
      console.log(i);
      red.set();
    }
  });
}