extends Node

const VERSION = "1.0"
const RELEASE_MODE = false

const SHOW_FPS = false and !RELEASE_MODE

const MAP_WIDTH = 500
const MAP_HEIGHT = 500

var rnd : RandomNumberGenerator

func _ready():
	if RELEASE_MODE:
		OS.window_fullscreen = true

	rnd = RandomNumberGenerator.new()
	rnd.randomize()
	pass
	
