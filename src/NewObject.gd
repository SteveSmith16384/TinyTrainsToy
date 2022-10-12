extends Node2D

#var station_class = preload("res://Station.tscm")
#ar obstacle_class = preload("res://Obstacle.tscm")

#enum Types {Station, Obstacle}

#var type: int
var payload
var clear = true
var count: int  = 0


func _process(_delta):
	count += 1
	if count > 3:
		if clear:
			create_object()
			call_deferred("queue_free")
		else:
			#put in new position!
			position = Vector2(Globals.rnd.randi_range(20, Globals.MAP_WIDTH), Globals.rnd.randi_range(20, Globals.MAP_HEIGHT))
			count = 0
			clear = true
	pass
	

func create_object():
	var p = self.get_parent()
	var c = self.payload#get_children()[0]
	c.position = self.position
	self.remove_child(payload)
	p.add_child(c)
	pass
	
	
func _on_Area2D_area_entered(area):
	var parent = area.get_parent()
	if parent == self:
		return
		
	clear = false
	pass
