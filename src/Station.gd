extends Node2D

onready var main = get_tree().get_root().get_node("Main")

var passengers = []
var colour : int

onready var time = OS.get_ticks_msec()

func _ready():
	colour = Globals.get_next_station_colour()
	$Sprite.texture = Globals.get_texture(colour)
	pass


func _on_NewPassengerTimer_timeout():
	if passengers.size() >= Globals.NUM_PASSENGERS_GAME_OVER:
		main.game_over()
		return
		
	var col = Globals.get_random_colour()
	while (col == colour): # Make sure passenger is diff colour
		col = Globals.get_random_colour()
	passengers.push_back(col)
	update_passenger_list()
	pass


func clear_passengers():
	passengers.clear()
	update_passenger_list()
	pass
	

func update_passenger_list():
	$PassengerList.update()
	pass


func _on_FlashTimer_timeout():
	if passengers.size() < Globals.NUM_PASSENGERS_WARNING:
		visible = true
	else:
		visible = not visible
	pass 

