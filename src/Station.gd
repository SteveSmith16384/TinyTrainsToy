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


func _on_AreaStationCloseCheck_area_entered(area): # todo - delete
	var parent = area.get_parent()
	if parent == self:
		return
	if area.is_in_group("stations"):
		Globals.num_actual_stations -= 1
		Globals.next_station_colour -= 1
		if self.time > parent.time:
			parent.queue_free()
		else:
#			if is_instance_valid(parent):
			self.queue_free()
	pass


func _on_FlashTimer_timeout():
	if passengers.size() < Globals.NUM_PASSENGERS_WARNING:
		visible = true
	else:
		visible = not visible
	pass 

