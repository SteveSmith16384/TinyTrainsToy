extends Node2D

onready var main = get_tree().get_root().get_node("Main")

var passengers = []
var colour : int

func _ready():
	colour = Globals.get_next_station_colour()#.get_random_colour()
	$Sprite.texture = Globals.get_texture(colour)
	pass


func _on_NewPassengerTimer_timeout():
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


func _on_Area_area_entered(_area):
	#var parent = area.get_parent()
	pass


func _on_AreaStationCloseCheck_area_entered(area):
	var parent = area.get_parent()
	if parent == self:
		return
	if area.is_in_group("stations"):
		parent.queue_free()
		Globals.num_actual_stations -= 1

	pass
