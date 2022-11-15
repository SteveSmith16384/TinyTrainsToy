extends Node2D

onready var main = get_tree().get_root().get_node("Main")

var passengers = []
var colour : int

func _ready():
	if Globals.game_mode != Globals.GameMode.ChangingStations:
		$ChangeColourTimer.queue_free()
	else:
		$ChangeColourTimer.start()
		
	colour = Globals.get_next_station_colour_number()
	$Sprite.texture = Globals.get_station_texture(colour)
	add_passenger()
	pass


func _on_NewPassengerTimer_timeout():
	if main.game_is_over:
		return
		
	if passengers.size() >= Globals.NUM_PASSENGERS_GAME_OVER:
		main.game_over()
		return
		
	add_passenger()
	pass
	

func add_passenger():
	var col = Globals.rnd.randi_range(0, Globals.MAX_STATION_COLOURS-1)
	while (col == colour): 
		col = Globals.rnd.randi_range(0, Globals.MAX_STATION_COLOURS-1)
	passengers.push_back(col)
	update_passenger_list()
	pass


func update_passenger_list():
	$PassengerList.update()
	pass


func _on_FlashTimer_timeout():
	if passengers.size() < Globals.NUM_PASSENGERS_WARNING:
		$PassengerList.visible = true
	else:
		$PassengerList.visible = not $PassengerList.visible
	pass 


func get_new_position():
	if Globals.game_mode == Globals.GameMode.Megalopolis or Globals.game_mode == Globals.GameMode.Earthquake:
		return Vector2(Globals.rnd.randi_range(100, Globals.MAP_WIDTH-100), Globals.rnd.randi_range(100, Globals.MAP_HEIGHT-100))
	else:
		var mx = Globals.MAP_WIDTH / 2
		var my = Globals.MAP_HEIGHT / 2
		var rad = Globals.num_stations * 75
		if rad >= my-50:
			rad = my-50
		var pos = Vector2(Globals.rnd.randi_range(mx-rad, mx+rad), Globals.rnd.randi_range(my-rad, my+rad))
		#print("New station at " + str(pos))
		return pos


func _on_ChangeColourTimer_timeout():
	if Globals.rnd.randi_range(0, 1) == 1:
		return
		
	colour = Globals.get_next_station_colour_number()
	$Sprite.texture = Globals.get_station_texture(colour)
	
	pass
