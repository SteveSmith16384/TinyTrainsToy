extends Node2D

var num_passengers:int = 0

func _ready():
	pass


func _on_NewPassengerTimer_timeout():
	num_passengers += 1
	update_label()
	pass


func set_num_passengers(i):
	num_passengers = i
	update_label()
	pass
	

func update_label():
	$Label.text = str(num_passengers)
	pass


func _on_Area_area_entered(area):
	var parent = area.get_parent()
	if area.is_in_group("stations"):
		parent.queue_free()
	pass
