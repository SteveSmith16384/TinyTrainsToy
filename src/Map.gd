extends Node2D

var station_class = preload("res://Station.tscn")
var obstacle_class = preload("res://Obstacle.tscn")
var new_object_class = preload("res://NewObject.tscn")

onready var main = get_tree().get_root().get_node("Main")


func _ready():
	if Globals.game_mode != Globals.GameMode.Simple:
		for i in 9:
			add_obstacle()

	for i in Globals.NUM_START_STATIONS:
		add_station()
		
	pass
	

func _on_NewStationTimer_timeout():
	if main.game_is_over:
		return
		
	add_station()
	if Globals.game_mode == Globals.GameMode.Megalopolis:
		add_station()
	elif Globals.game_mode == Globals.GameMode.Earthquake:
		add_obstacle()
		
	#$NewStationTimer.wait_time += 2#4
	pass


func add_station():
	Globals.num_stations += 1
	var station = station_class.instance()
	
	var obj = new_object_class.instance()
	obj.visible = false
	
	obj.position = station.get_new_position()
	obj.add_child(station)
	obj.payload = station

	add_child(obj)
	pass


func add_obstacle():
	var obs = obstacle_class.instance()
	var obj = new_object_class.instance()
	obj.visible = false
	var pos = obs.get_new_position()
	obj.position = pos
	add_child(obj)

	obj.payload = obs
	obj.add_child(obs)

	pass

