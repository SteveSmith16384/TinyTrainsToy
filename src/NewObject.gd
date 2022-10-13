extends Node2D

var payload
var clear = true
var count: int  = 0


func _process(_delta):
	count += 1
	if count > 2:
		if clear:
			create_object()
			call_deferred("queue_free")
		else:
			count = 0
			clear = true
			#put in new position!
			position = payload.get_new_position() #Vector2(Globals.rnd.randi_range(20, Globals.MAP_WIDTH), Globals.rnd.randi_range(20, Globals.MAP_HEIGHT))
	pass
	

func create_object():
	var map = self.get_parent()
	var obj = self.payload
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
		
	clear = false
	pass
