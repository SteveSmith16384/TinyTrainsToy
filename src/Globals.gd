extends Node

const VERSION = "1.0"
const RELEASE_MODE = false

const SHOW_FPS = false and !RELEASE_MODE

const MAP_WIDTH = 800
const MAP_HEIGHT = 600
const SQ_SIZE = 10
const MAX_COLOURS = 3
const NUM_PASSENGERS_WARNING = 6
const NUM_PASSENGERS_GAME_OVER = 8

var next_pri : int = 0
var next_station_colour :int = 0

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
	

func get_next_priority():
	next_pri += 1
	return next_pri


func get_random_colour():
	return rnd.randi_range(0, MAX_COLOURS-1)
	

func get_texture(col:int):
	match (col):
		0: return load("res://Assets/Sprites/green_circle.png")
		1: return load("res://Assets/Sprites/red_circle.png")
		2: return load("res://Assets/Sprites/yellow_circle.png")
		_: 
			print("ERROR " + str(col))
			return null
	pass


func get_next_station_colour():
	next_station_colour += 1
#	while (next_station_colour < 0):
#		next_station_colour += 1
	if next_station_colour >= MAX_COLOURS:
		next_station_colour = 0
	return next_station_colour
	
	
