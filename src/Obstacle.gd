extends Node2D

func get_new_position():
	return Vector2(Globals.rnd.randi_range(100, Globals.MAP_WIDTH-100), Globals.rnd.randi_range(100, Globals.MAP_HEIGHT-100))
	
