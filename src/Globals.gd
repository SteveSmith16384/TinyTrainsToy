extends Node

const VERSION = "1.0"
const RELEASE_MODE = false

const SHOW_FPS = false and !RELEASE_MODE

const MAP_WIDTH = 500
const MAP_HEIGHT = 500
const SQ_SIZE = 10

var rnd : RandomNumberGenerator

func _ready():
	if RELEASE_MODE:
		OS.window_fullscreen = true

	rnd = RandomNumberGenerator.new()
	rnd.randomize()
	pass
	

func gridify_pos(pos : Vector2):
	var x : int = pos.x / SQ_SIZE
	x = x * SQ_SIZE
	var y : int = pos.y / SQ_SIZE
	y = y * SQ_SIZE
	return Vector2(x, y)
	
