extends Path2D

var junction_class = preload("res://Junction.tscn")
var train_class = preload("res://Train.tscn")

func _ready():
	self.self_modulate = Color.black
	pass


func get_end_pos():
	return self.curve.get_point_position(curve.get_point_count()-1)

	
func add_junction(pos:Vector2):
	var junc = junction_class.instance()
	junc.position = pos
	junc.point_idx = curve.get_point_count()
	self.add_child(junc)

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
		draw_polyline(points, Color.black, 5.0)
	pass
	
