extends Node2D

var passengers = []
var colour : int

func _ready():
	colour = Globals.get_next_station_colour()#.get_random_colour()
	$Sprite.texture = Globals.get_texture(colour)
	pass


func _on_NewPassengerTimer_timeout():
	passengers.push_back(Globals.get_random_colour())
	update_passenger_list()
	pass


func clear_passengers():
	passengers.clear()
	update_passenger_list()
	pass
	

func update_passenger_list():
	$PassengerList.update()
	pass


func _on_Area_area_entered(area):
	var parent = area.get_parent()
	if area.is_in_group("stations"):
		parent.queue_free()
	pass
