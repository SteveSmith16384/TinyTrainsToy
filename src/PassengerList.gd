extends Node2D

func update():
	var pas = get_parent().passengers
	while $HBoxContainer.get_child_count() > 0:
		var ch = $HBoxContainer.get_child(0)
		$HBoxContainer.remove_child(ch)
#	for ch in $HBoxContainer.get_children():
#		$HBoxContainer.remove_child(ch)
#		ch.queue_free()
		
	for p in pas:
		var tex = TextureRect.new()
		tex.texture = Globals.get_texture(p)
		$HBoxContainer.add_child(tex)
	pass
	
