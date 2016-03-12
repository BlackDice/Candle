(function() {
  var Candle;

  Candle = function(options) {
    var config, getIntensity, getRandom, prop, update;
    this.flameIntensity = 0;
    this.flame = 0;
    this.wind = 0;
    config = {
      flameBaseline: 150,
      flameRiseSpeed: 1,
      flameAgility: 3,
      windBaseline: 10,
      windFalloffSpeed: 1,
      windCalmness: 2,
      windChance: 5
    };
    if ((options != null ? options.length : void 0) > 0) {
      for (prop in options) {
        if (options.hasOwnProperty(prop)) {
          config[prop] = options[prop];
        }
      }
    }
    getRandom = function() {
      return Math.random() * 255;
    };
    update = function() {
      var rnd;
      if (getRandom() < config.windChance) {
        this.wind = getRandom();
      }
      if (this.wind > config.windBaseline) {
        this.wind -= config.windFalloffSpeed;
      }
      if (this.flame < 255) {
        this.flame += config.flameRiseSpeed;
      }
      rnd = getRandom();
      if (rnd < (wind >> config.windCalmness)) {
        this.flame = rnd;
        if (this.flame < config.flameBaseline) {
          this.flame = config.flameBaseline;
        }
      }
      if (this.flame > config.flameIntensity) {
        if (config.flameIntensity < 255 - config.flameAgility) {
          return config.flameIntensity += config.flameAgility;
        }
      } else {
        if (config.flameIntensity > config.flameAgility) {
          return config.flameIntensity -= config.flameAgility;
        }
      }
    };
    getIntensity = function() {
      return this.flameIntensity / 255;
    };
    return this;
  };

  module.exports = new Candle();

  module.exports.create = function() {
    return Candle();
  };

}).call(this);
