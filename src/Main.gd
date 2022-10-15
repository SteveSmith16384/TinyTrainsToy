extends Node2D

var train_line_class = preload("res://TrainLine.tscn")

var dragging = false
var selected_junction = null
var mouse_pos : Vector2
var prev_mouse_pos : Vector2
var prev_button_mask: int = 0
var mouse_over_icons = false
var game_is_over = false
var money: float = 100.0

func _input(event):
	if mouse_over_icons:
		return
		
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		dragging = false
		var ev: InputEventMouseButton = event
		if ev.pressed:
			if ev.button_mask == 1:
				var sel = get_selection_at(ev.position)
				if sel != null:
					selected_junction = sel
					dragging = true
			elif event.button_index == BUTTON_WHEEL_UP:
				pass
			elif event.button_index == BUTTON_WHEEL_DOWN:
				pass
			else:
				if selected_junction != null:
					if selected_junction.get_parent().curve.get_point_count() <= 1:
						selected_junction.get_parent().queue_free()
				selected_junction = null
				#dragging = true # dragging map
			pass
			prev_button_mask = ev.button_mask
		elif ev.button_index == prev_button_mask: # Released
			if prev_button_mask == 1:
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
	elif event is InputEventKey:
		var key:InputEventKey = event
		if key.pressed:
			if key.scancode == KEY_DELETE:
				if selected_junction != null:
					selected_junction.get_parent().delete_junction(selected_junction)
					selected_junction = null
	pass


func get_selection_at(screen_position:Vector2):
	var intersections = get_world_2d().direct_space_state.intersect_point(screen_position, 32, [], 0x7FFFFFFF, true, true )
	if intersections.size() > 0:
		for intersection in intersections:
			var area = intersection.collider
			var parent = area.get_parent()
			if parent.is_in_group("junctions"):
				return parent
			elif parent.is_in_group("trains"):
				parent.dir = parent.dir * -1
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
			if train_line.curve.get_point_count() == 2:
				buy_train(true)
	pass
	
	
func _process(_delta):
	update()
	pass
	

func _draw():
	if dragging:
		return
	if mouse_pos != null and selected_junction != null and mouse_over_icons == false:
		var train_line = selected_junction.get_parent()
		var end = (train_line.get_end_pos() + $Map.position) * $Map.scale
		draw_line(end, mouse_pos, Color.gray, 4)
	pass
	
	
func buy_train(free:bool):
	if not free and money < 100:
		$HUD.set_status_text("Not enough money!")
		return
		
	if selected_junction != null:
		var train_line = selected_junction.get_parent()
		train_line.add_train()
		if not free:
			money -= 100
	else:
		$HUD.set_status_text("No track selected")
	pass


func game_over():
	$HUD.set_status_text("GAME OVER!")
	game_is_over = true
	pass


func _on_OneSecTimer_timeout():
	$HUD.set_money(int(money))
	pass
