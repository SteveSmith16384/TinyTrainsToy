extends Node2D

var payload
var count: int  = 0


func _process(_delta):
	count += 1
	if count > 2:
		var clear = true
		var areas = $Area2D.get_overlapping_areas()
		for area in areas:
			var parent = area.get_parent()
			if parent == self:
				continue
			if parent == payload:
				continue
			clear = false
			break
			
		if clear:
			create_object()
			call_deferred("queue_free")
		else:
			count = 0
			position = payload.get_new_position()
	pass
	

func create_object():
	var map = self.get_parent()
	var obj = self.payload
	obj.visible = true
	self.remove_child(obj)
	map.add_child(obj)
	obj.position = self.position
	obj.update()
	pass
	
	
func _on_Area2D_area_entered(area):
	var parent = area.get_parent()
	if parent == self:
		return
	if parent == payload:
		return
	pass
