# Candle

This library is a simplified javascript rewrite of this method witen in C++: [insert github link]

Use this library if you want to get a *single value* of flame intensity being changed by random gusts of wind.
The resulting intensity is in 0-1 range, all input values have to be in 0-255 range.

## Options

Optionally you can pass an options object to set these variables:

- flameBaseline: Starting value of the flame intensity
- windBaseline: Starting value of the wind intensity

- flameRiseSpeed: How quickly the flame should rise without wind
- windFalloffSpeed: How quickly the gust of wind should calm down

- windChance: What is the likelihood of getting a wind gust each update

- flameAgility: 
- windCalmness: 

## Usage

Create an instance of the candle object and call updates on it with each requestAnimationFrame tick.
The loop is not included, if you don't have one, you can use this:

```
candle = new Candle()

loop = (timestamp) ->
	candle.update()
	intensity = candle.getIntensity()
	requestAnimationFrame loop
loop()
```
