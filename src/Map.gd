extends Node2D

var station_class = preload("res://Station.tscn")


func _ready():
	for i in 3:
		add_station()
	pass
	

func _on_NewStationTimer_timeout():
	add_station()
	pass


func add_station():
	var station = station_class.instance()
	var pos = Vector2(Globals.rnd.randi_range(0, Globals.MAP_WIDTH), Globals.rnd.randi_range(0, Globals.MAP_HEIGHT))
	station.position = pos
	add_child(station)
	pass
	
