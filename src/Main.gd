extends Node2D

var train_line_class = preload("res://TrainLine.tscn")

var dragging = false
var selected_junction = null
var mouse_pos

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		var ev: InputEventMouseButton = event
		if ev.pressed:
			if ev.button_mask == 1:
				if ev.position.x > $Map.position.x:
					var adj_pos = $Map.get_local_mouse_position()
					check_intersection(ev.position, adj_pos)
					#add_junction(self.get_local_mouse_position())#event.position)
					pass
			else:
				selected_junction = null
		pass
	elif event is InputEventMouseMotion:
		mouse_pos = event.position
#		print("Mouse Motion at: ", event.position)
		pass
	pass


func _process(delta):
	update()
	pass
	

func _draw():
#	var pos = self.get_local_mouse_position()
	if mouse_pos != null and selected_junction != null:
		var train_line = selected_junction.get_parent()
		var end = train_line.end_pos + $Map.position

		draw_line(end, mouse_pos, Color(255, 0, 0), 1)
#	draw_line(Vector2(0,0), Vector2(50, 50), Color(255, 0, 0), 1)
	pass
	
	
func check_intersection(screen_position : Vector2, map_position: Vector2 ):
	var intersections = get_world_2d().direct_space_state.intersect_point(screen_position, 32, [], 0x7FFFFFFF, true, true )

	if intersections.size() > 0:
#		for i in intersections:
		#print( "Intersection: " + intersections[i] )
		var i = 0
		var area = intersections[i].collider
		var parent = area.get_parent()
		if parent.is_in_group("junctions"):
			selected_junction = parent
		pass
	else:
		if selected_junction == null:
			# start new line
			var train_line = train_line_class.instance()
			train_line.curve = Curve2D.new()
			selected_junction = train_line.add_junction(map_position)
			$Map.add_child(train_line)
		else:
			# Continue existing line
			var train_line = selected_junction.get_parent()
			selected_junction = train_line.add_junction(map_position)
	pass
	
	
func _on_BuyTrainButton_pressed():
	if selected_junction != null:
		var train_line = selected_junction.get_parent()
		train_line.add_train()
	pass
