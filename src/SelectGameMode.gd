extends Node2D



func _on_SimpleMode_pressed():
	Globals.UNIQUE_STATION = false
	Globals.MAX_TRACKS = 4
	Globals.NUM_START_STATIONS = 3
	Globals.MAX_STATION_COLOURS = 3
	start()
	pass 


func _on_SingleTrack_pressed():
	Globals.UNIQUE_STATION = false
	Globals.MAX_TRACKS = 1
	Globals.NUM_START_STATIONS = 3
	Globals.MAX_STATION_COLOURS = 3
	start()
	pass 


func _on_UniqueStation_pressed():
	Globals.UNIQUE_STATION = true
	Globals.MAX_TRACKS = 4
	Globals.NUM_START_STATIONS = 3
	Globals.MAX_STATION_COLOURS = 4 # One extra for the unique station 
	start()
	pass 


func start():
	var _unused = get_tree().change_scene("res://Main.tscn")
	pass


func _on_MegalopolisMode_pressed():
	Globals.UNIQUE_STATION = false
	Globals.MAX_TRACKS = 5
	Globals.NUM_START_STATIONS = 10
	Globals.MAX_STATION_COLOURS = 5
	start()
	pass
	
	
