extends Path2D

var junction_class = preload("res://Junction.tscn")
var train_class = preload("res://Train.tscn")
var colour : Color
var prev_junction
var junctions = []


func _ready():
	colour = Globals.get_next_track_colour()
	self.self_modulate = colour #Color.black
	pass


func get_end_pos():
	return self.curve.get_point_position(curve.get_point_count()-1)

	
func add_junction(pos:Vector2):
	var junc = junction_class.instance()
	junc.position = pos
	junc.point_idx = curve.get_point_count()
	self.add_child(junc)
	junctions.push_back(junc)
	
	if prev_junction != null:
		prev_junction.get_node("TrackSprite").queue_free()
	prev_junction = junc

	if curve.get_point_count() > 0:
		junc.get_node("TrainSprite").queue_free()
#	else:
#		junc.get_node("TrackSprite").queue_free()
	curve.add_point(pos)
	update()
	return junc
	
	
func add_train():
	var train = train_class.instance()
	train.position = curve.get_point_position(0)# start_pos#pos
	self.add_child(train)
	pass
	

func _draw():
	var points = curve.get_baked_points()
	if points.size() > 1:
		draw_polyline(points, Color.black, 9.0)
		draw_polyline(points, colour, 6.0)
	pass
	

func delete_junction(junc):
	var idx = junctions.find(junc)
	if idx == 0:
		return # Can't delete first function
	self.remove_child(junc)
	if prev_junction == junc:
		prev_junction = null
	junc.queue_free()
	junctions.remove(idx)
	curve.remove_point(idx)
	
	update()
	
#	if curve.get_point_count() == 0:
#		self.queue_free()
	pass
	
