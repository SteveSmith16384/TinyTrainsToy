extends PathFollow2D

var num_passangers :int = 0
var num_colliding_trains = 0

func _process(delta):
	if num_colliding_trains == 0:
		offset += delta * 20
	pass


func _on_Area2D_area_entered(area):
	var parent = area.get_parent()
	if area.get_parent() == self:
		return
	if parent.is_in_group("stations"):
		num_passangers = parent.num_passangers
		parent.num_passangers = 0
	elif parent.is_in_group("trains"):
		num_colliding_trains += 1
	else:
		print("Here")
	pass


func _on_Area2D_area_exited(area):
	var parent = area.get_parent()
	if parent.is_in_group("trains"):
		num_colliding_trains -= 1
	pass
