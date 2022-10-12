extends Node2D

var train_line_class = preload("res://TrainLine.tscn")

var dragging = false
var selected_junction = null
var mouse_pos : Vector2
var prev_mouse_pos : Vector2
var prev_button_mask: int = 0

func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		dragging = false
		var ev: InputEventMouseButton = event
		if ev.pressed:
			if ev.button_mask == 1:
				#var adj_pos = $Map.get_local_mouse_position()
				var sel = get_selection_at(ev.position)
				if sel != null:
					selected_junction = sel
					dragging = true
			else:
				selected_junction = null
				dragging = true # dragging map
			pass
			prev_button_mask = ev.button_mask
		else: # Released
			if prev_button_mask == 1:
				if ev.position.x > $Map.position.x:
					var adj_pos = $Map.get_local_mouse_position()
					check_intersection(ev.position, adj_pos)
					pass
			else:
				selected_junction = null
		pass
		prev_mouse_pos = event.position
	elif event is InputEventMouseMotion:
		#print("Mouse Motion at: ", event.position)
		mouse_pos = event.position
		if dragging:
			if selected_junction != null:
				selected_junction.position = $Map.get_local_mouse_position()
				selected_junction.set_curve_point()
			elif prev_button_mask == 2:
				var offset = event.position - prev_mouse_pos
				$Map.position += offset
		pass
		prev_mouse_pos = event.position
		
	pass


func get_selection_at(screen_position:Vector2):
	var intersections = get_world_2d().direct_space_state.intersect_point(screen_position, 32, [], 0x7FFFFFFF, true, true )
	if intersections.size() > 0:
		for intersection in intersections:
			var area = intersection.collider
			var parent = area.get_parent()
			if parent.is_in_group("junctions"):
				return parent
	pass
	
		
func check_intersection(screen_position : Vector2, map_position: Vector2 ):
	var sel = get_selection_at(screen_position)
	if sel == null:
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
	
	
func _process(_delta):
	update()
	pass
	

func _draw():
	if mouse_pos != null and selected_junction != null:
		var train_line = selected_junction.get_parent()
		var end = train_line.get_end_pos() + $Map.position
		draw_line(end, mouse_pos, Color.gray, 2)
	pass
	
	
func _on_BuyTrainButton_pressed():
	if selected_junction != null:
		var train_line = selected_junction.get_parent()
		train_line.add_train()
	else:
		$HUD.set_status_text("No track selected")
	pass


func game_over():
	# todo
	pass
	
	
