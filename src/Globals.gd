extends Node

const VERSION = "1.0"
const RELEASE_MODE = false

const SHOW_FPS = false and !RELEASE_MODE

const MAP_WIDTH = 1920-200
const MAP_HEIGHT = 1080-200
const SQ_SIZE = 10
const MAX_STATION_COLOURS = 4
const MAX_TRACK_COLOURS = 5
const NUM_PASSENGERS_WARNING = 6
const NUM_PASSENGERS_GAME_OVER = 8

const MAX_TRACKS = 4 # Game option

var next_pri : int = 0
var next_station_colour :int = 0
var next_track_colour :int = 0
var num_stations:int = 0

var rnd : RandomNumberGenerator

func _ready():
	if RELEASE_MODE:
		OS.window_fullscreen = true

	rnd = RandomNumberGenerator.new()
	rnd.randomize()
	pass
	

func gridify_pos(pos : Vector2):
	var x : int = pos.x / float(SQ_SIZE)
	x = x * SQ_SIZE
	var y : int = pos.y / float(SQ_SIZE)
	y = y * SQ_SIZE
	return Vector2(x, y)
	

func get_next_priority():
	next_pri += 1
	return next_pri


func get_texture(col:int):
	match (col):
		0: return load("res://Assets/Sprites/green_circle.png")
		1: return load("res://Assets/Sprites/red_circle.png")
		2: return load("res://Assets/Sprites/yellow_circle.png")
		3: return load("res://Assets/Sprites/blue_circle.png")
		4: return load("res://Assets/Sprites/cyan_circle.png")
		_: 
			print("ERROR " + str(col))
			return null
	pass


func get_next_station_colour_number() -> int:
	var next = next_station_colour
	next_station_colour += 1
	if next_station_colour >= MAX_STATION_COLOURS:
		next_station_colour = 1 # Skip 0 and it's unique!
	return next
	
	
func get_next_track_colour() -> Color:
	next_track_colour += 1
	if next_track_colour >= MAX_TRACK_COLOURS:
		next_track_colour = 0
	match next_track_colour:
		0: return Color.yellow
		1: return Color.green
		2: return Color.blue
		3: return Color.magenta
		4: return Color.cyan
		5: return Color.red
	return Color.black
