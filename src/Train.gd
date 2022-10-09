extends PathFollow2D

var num_passangers :int = 0

func _ready():	
	pass


func _process(delta):
	offset += delta * 20
	pass


func _on_Area2D_area_entered(area):
	if area.get_parent() == self:
		return
	if area.get_parent().is_in_group("stations"):
		var station = area.get_parent()
		num_passangers = station.num_passangers
		station.num_passangers = 0
	else:
		print("Here")
	pass
