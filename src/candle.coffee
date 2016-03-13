
defaults = require 'lodash.defaults'

getRandom = ->
	return Math.random() * 255

Candle = (options) ->

	flameIntensity = 0
	flame = 0
	wind = 0

	# defaults
	options = defaults options, {
		flameBaseline: 150
		flameRiseSpeed: 1
		flameAgility: 3
		windBaseline: 10
		windFalloffSpeed: 1
		windCalmness: 2
		windChance: 5
	}

	update = ->
		# If chance allows, set wind to random strength
		if getRandom() < options.windChance
			wind = getRandom()

		# The wind constantly settles towards its baseline value
		if wind > options.windBaseline
			wind -= options.windFalloffSpeed

		# The flame constantly gets brighter till the wind knocks it down
		if flame < 255
			flame += options.flameRiseSpeed

		# Depending on the wind strength and the calmness modifer we calcuate the odds
		# of the wind knocking down the flame by setting it to random value
		rnd = getRandom()
		if rnd < (wind>>options.windCalmness)
			flame = rnd
			if flame < options.flameBaseline
				flame = options.flameBaseline

		# Real flames look like they have inertia so we use this
		# constant-aproach-rate filter to lowpass the flame height
		if flame > flameIntensity
			if flameIntensity < 255 - options.flameAgility
				flameIntensity += options.flameAgility
		else
			if flameIntensity > options.flameAgility
				flameIntensity -= options.flameAgility

	getIntensity = ->
		return flameIntensity / 255

	return { update, getIntensity }

# Module returns default instance to be used globally
module.exports = Candle


