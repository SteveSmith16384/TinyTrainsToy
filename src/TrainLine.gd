extends Path2D

var junction_class = preload("res://Junction.tscn")
var train_class = preload("res://Train.tscn")

onready var main = get_tree().get_root().get_node("Main")

var colour : Color
var junctions = [] # Must be same order as curnve points


func _ready():
	colour = Globals.get_next_track_colour()
	self.self_modulate = colour
	pass


func get_end_pos():
	return self.curve.get_point_position(curve.get_point_count()-1)

	
func add_junction(pos:Vector2):
	var junc = junction_class.instance()
	junc.position = pos
	self.add_child(junc)
	junctions.push_back(junc)
	
	update_junction_icons()
	
	if curve.get_point_count() > 0:
		junc.get_node("TrainSprite").queue_free()

	curve.add_point(pos)
	update()
	return junc
	

func update_junction_icons():
	for idx in junctions.size():
		junctions[idx].get_node("TrackSprite").visible = idx >= junctions.size()-1
	pass
	
	
func add_train(junc):
	var train = train_class.instance()
	if junc != null:
		train.offset = curve.get_closest_offset(junc.position)
	self.add_child(train)
	pass
	

func _draw():
	var points = curve.get_baked_points()
	if points.size() > 1:
		draw_polyline(points, Color.black, 10.0)
		draw_polyline(points, colour, 6.0)
	pass
	

func insert_junction(orig_junc):
	var idx = junctions.find(orig_junc)

	var new_junc = junction_class.instance()
	new_junc.position = orig_junc.position
	new_junc.position.x += 20
	new_junc.position.y += 20
	new_junc.get_node("TrainSprite").queue_free()
	self.add_child(new_junc)
	junctions.insert(idx+1, new_junc)
	
	update_junction_icons()
	
	curve.add_point(orig_junc.position, Vector2(), Vector2(), idx+1)
	new_junc.set_curve_point()
	update()
	
	main.set_status_text("Junction inserted")
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
	
	if junc == main.selected_junction:
		main.selected_junction = null
		
	update()
	pass
	
