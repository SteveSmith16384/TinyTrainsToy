extends Path2D

var junction_class = preload("res://Junction.tscn")
var train_class = preload("res://Train.tscn")

#onready var main = get_tree().get_root().get_node("Main")

#var start_pos:Vector2
#var end_pos:Vector2

func _ready():
	self.self_modulate = Color.black
	pass


func get_end_pos():
	return self.curve.get_point_position(curve.get_point_count()-1)

	
func add_junction(pos:Vector2):
	if pos.x < 0:
		return
		
	var junc = junction_class.instance()
	junc.position = pos
	junc.point_idx = curve.get_point_count()
	self.add_child(junc)

#	if start_pos.length() == 0: # First position?
#		start_pos = pos
#	end_pos = pos
	
	curve.add_point(pos)
	return junc
	
	
func add_train():
	var train = train_class.instance()
	train.position = curve.get_point_position(0)# start_pos#pos
	self.add_child(train)
	pass


