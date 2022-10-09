extends Path2D

var station_class = preload("res://Station.tscn")
var junction_class = preload("res://Junction.tscn")
var train_class = preload("res://Train.tscn")

#onready var main = get_tree().get_root().get_node("Main")

var start_pos:Vector2

func _ready():
#	curve.add_point(Vector2(20, 20))
#	curve.add_point(Vector2(50, 30))
#	curve.add_point(Vector2(70, 90))
#	curve.add_point(Vector2(20, 20))
	
#	$TileMap.set_cell(0, 0, 0)

	for i in 3:
		add_station()
	pass


func _input(event):
   # Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		var ev: InputEventMouseButton = event
#		print("Mouse Click/Unclick at: ", event.position)
		#curve.add_point(event.position)
		if ev.button_mask == 1 and ev.pressed:
			add_junction(self.get_local_mouse_position())#event.position)
		pass
	elif event is InputEventMouseMotion:
#		print("Mouse Motion at: ", event.position)
		pass
	pass
	

func add_junction(pos:Vector2):
	if pos.x < 0:
		return
		
	var junc = junction_class.instance()
	junc.position = pos
	self.add_child(junc)

	if start_pos.length() == 0: # First position?
		start_pos = pos
		call_deferred("buy_train", start_pos)
		
	curve.add_point(pos)
	pass
	
	
func buy_train(pos:Vector2):
	var train = train_class.instance()
	train.position = pos
	self.add_child(train)
	pass


func _on_NewStationTimer_timeout():
	add_station()
	pass


func add_station():
	var station = station_class.instance()
	var pos = Vector2(Globals.rnd.randi_range(0, Globals.MAP_WIDTH), Globals.rnd.randi_range(0, Globals.MAP_HEIGHT))
	station.position = pos
	add_child(station)
	pass
	
