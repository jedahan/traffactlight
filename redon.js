var gpio = require("gpio");

for(var i=0; i<28; i++) {
  var red = gpio.export(i, {
    direction: 'out',
    ready: function() {
      console.log(i);
      red.set();
    }
  });
}