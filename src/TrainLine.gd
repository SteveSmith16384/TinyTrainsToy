extends Path2D

var junction_class = preload("res://Junction.tscn")
var train_class = preload("res://Train.tscn")
var colour : Color
var junctions = []


func _ready():
	colour = Globals.get_next_track_colour()
	self.self_modulate = colour
	pass


func get_end_pos():
	return self.curve.get_point_position(curve.get_point_count()-1)

	
func add_junction(pos:Vector2):
	var junc = junction_class.instance()
	junc.position = pos
	#junc.point_idx = curve.get_point_count()
	self.add_child(junc)
	junctions.push_back(junc)
	
#	if prev_junction != null:
#		prev_junction.get_node("TrackSprite").visible = false
#	prev_junction = junc

	update_junction_icons()
	
	if curve.get_point_count() > 0:
		junc.get_node("TrainSprite").queue_free()
#	else:
#		junc.get_node("TrackSprite").queue_free()
	curve.add_point(pos)
	update()
	return junc
	

func update_junction_icons():
	# Update junction icons
	for idx in junctions.size():
		junctions[idx].get_node("TrackSprite").visible = idx >= junctions.size()-1
	pass
	
	
func add_train():
	var train = train_class.instance()
	train.position = curve.get_point_position(0)# start_pos#pos
	self.add_child(train)
	pass
	

func _draw():
	var points = curve.get_baked_points()
	if points.size() > 1:
		draw_polyline(points, Color.black, 10.0)
		draw_polyline(points, colour, 6.0)
	pass
	

func delete_junction(junc):
	var idx = junctions.find(junc)
	if idx == 0:
		return # Can't delete first junction
	self.remove_child(junc)
	junc.queue_free()
	junctions.remove(idx)
	curve.remove_point(idx)

	update_junction_icons()
	
	update()
	
#	if curve.get_point_count() == 0:
#		self.queue_free()
	pass
	
