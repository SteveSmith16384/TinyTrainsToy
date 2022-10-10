extends Path2D

var junction_class = preload("res://Junction.tscn")
var train_class = preload("res://Train.tscn")

#onready var main = get_tree().get_root().get_node("Main")

var start_pos:Vector2

func add_junction(pos:Vector2):
	if pos.x < 0:
		return
		
	var junc = junction_class.instance()
	junc.position = pos
	self.add_child(junc)

	if start_pos.length() == 0: # First position?
		start_pos = pos

	curve.add_point(pos)
	return junc
	
	
func add_train():
	var train = train_class.instance()
	train.position = start_pos#pos
	self.add_child(train)
	pass


