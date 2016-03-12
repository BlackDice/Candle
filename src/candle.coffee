
Candle = (options) ->

	this.flameIntensity = 0
	this.flame = 0
	this.wind = 0

	# defaults
	config = {
		flameBaseline: 150
		flameRiseSpeed: 1
		flameAgility: 3
		windBaseline: 10
		windFalloffSpeed: 1
		windCalmness: 2
		windChance: 5
	}

	if options?.length > 0
		for prop of options
			if options.hasOwnProperty prop
				config[prop] = options[prop]

	getRandom = ->
		return Math.random() * 255

	update = ->
		# If chance allows, set wind to random strength
		if getRandom() < config.windChance
			this.wind = getRandom()

		# The wind constantly settles towards its baseline value
		if this.wind > config.windBaseline
			this.wind -= config.windFalloffSpeed

		# The flame constantly gets brighter till the wind knocks it down
		if this.flame < 255
			this.flame += config.flameRiseSpeed

		# Depending on the wind strength and the calmness modifer we calcuate the odds
		# of the wind knocking down the flame by setting it to random value
		rnd = getRandom()
		if rnd < (wind>>config.windCalmness)
			this.flame = rnd
			if this.flame < config.flameBaseline
				this.flame = config.flameBaseline

		# Real flames look like they have inertia so we use this
		# constant-aproach-rate filter to lowpass the flame height
		if this.flame > config.flameIntensity
			if config.flameIntensity < 255 - config.flameAgility
				config.flameIntensity += config.flameAgility
		else
			if config.flameIntensity > config.flameAgility
				config.flameIntensity -= config.flameAgility

	getIntensity = ->
		return this.flameIntensity / 255

	return this

# Module returns default instance to be used globally
module.exports = new Candle()

# Export function to create separate promised land for custom use
module.exports.create = ->
	Candle()


