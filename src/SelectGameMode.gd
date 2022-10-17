extends Node2D


func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
		return
	pass
	
	
func _on_SimpleMode_pressed():
	Globals.game_mode = Globals.GameMode.Simple
	
	Globals.UNIQUE_STATION = false
	Globals.MAX_TRACKS = 4
	Globals.NUM_START_STATIONS = 3
	Globals.MAX_STATION_COLOURS = 3
	start()
	pass 


func _on_NormalMode_pressed():
	Globals.game_mode = Globals.GameMode.Other
	
	Globals.UNIQUE_STATION = false
	Globals.MAX_TRACKS = 4
	Globals.NUM_START_STATIONS = 3
	Globals.MAX_STATION_COLOURS = 4
	start()
	pass 


func _on_SingleTrack_pressed():
	Globals.game_mode = Globals.GameMode.Other

	Globals.UNIQUE_STATION = false
	Globals.MAX_TRACKS = 1
	Globals.NUM_START_STATIONS = 3
	Globals.MAX_STATION_COLOURS = 3
	start()
	pass 


func _on_UniqueStation_pressed():
	Globals.game_mode = Globals.GameMode.Other

	Globals.UNIQUE_STATION = true
	Globals.MAX_TRACKS = 4
	Globals.NUM_START_STATIONS = 4
	Globals.MAX_STATION_COLOURS = 4 # One extra for the unique station 
	start()
	pass 


func start():
	Globals.reset()
	
	var _unused = get_tree().change_scene("res://Main.tscn")
	pass


func _on_MegalopolisMode_pressed():
	Globals.game_mode = Globals.GameMode.Megalopolis

	Globals.UNIQUE_STATION = false
	Globals.MAX_TRACKS = 5
	Globals.NUM_START_STATIONS = 10
	Globals.MAX_STATION_COLOURS = 5
	Globals.START_MONEY = 200
	start()
	pass
	

func _on_EarthquakeMode_pressed():
	Globals.game_mode = Globals.GameMode.Earthquake
	
	Globals.UNIQUE_STATION = false
	Globals.MAX_TRACKS = 5
	Globals.NUM_START_STATIONS = 4
	Globals.MAX_STATION_COLOURS = 3
	start()
	pass




func _on_Full_Screen_pressed():
	OS.window_fullscreen = !OS.window_fullscreen
	pass
