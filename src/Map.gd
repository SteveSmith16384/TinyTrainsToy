extends Node2D

var station_class = preload("res://Station.tscn")


func _ready():
	for i in 3:
		add_station()
	pass
	

func _process(_delta):
	if Globals.num_actual_stations < Globals.num_required_stations:
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
	add_child(station)
	Globals.num_actual_stations += 1
	pass
	
