extends Node2D

var station_class = preload("res://Station.tscn")
var obstacle_class = preload("res://Obstacle.tscn")
var new_object_class = preload("res://NewObject.tscn")

onready var main = get_tree().get_root().get_node("Main")


func _ready():
	for i in Globals.MAX_STATION_COLOURS:
		add_station()
	for i in 9:
		add_obstacle()
	pass
	

func _on_NewStationTimer_timeout():
	if main.game_is_over:
		return
		
	add_station()
	$NewStationTimer.wait_time += 4
	pass


func add_station():
	Globals.num_stations += 1
	var station = station_class.instance()
	
	var obj = new_object_class.instance()
	
	obj.position = station.get_new_position()
	obj.add_child(station)
	obj.payload = station

	add_child(obj)
	pass


func add_obstacle():
	var obs = obstacle_class.instance()
	obs.visible = false
	var obj = new_object_class.instance()
	var pos = obs.get_new_position()
	obj.position = pos
	add_child(obj)

	obj.payload = obs
	obj.add_child(obs)

	pass

