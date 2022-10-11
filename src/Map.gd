extends Node2D

var station_class = preload("res://Station.tscn")
var new_object_class = preload("res://NewObject.tscn")

func _ready():
	for i in 3:
		add_station()
	pass
	

func _on_NewStationTimer_timeout():
	Globals.num_required_stations += 1
	$NewStationTimer.wait_time += 20# $NewStationTimer.wait_time * 2
	pass


func add_station():
	var station = station_class.instance()
	var pos = Vector2(Globals.rnd.randi_range(20, Globals.MAP_WIDTH), Globals.rnd.randi_range(20, Globals.MAP_HEIGHT))
	station.position = pos
	
	var obj = new_object_class.instance()
	obj.position = pos
	obj.add_child(station)
	obj.payload = station

	add_child(obj)
	pass


func _on_OneSecTimer_timeout():
	var num_actual_stations = 0
	for ch in get_children():
		if ch.is_in_group("stations"):
			num_actual_stations += 1
	if num_actual_stations < Globals.num_required_stations:
		add_station()
	pass
