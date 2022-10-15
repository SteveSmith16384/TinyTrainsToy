extends Node2D

onready var main = get_tree().get_root().get_node("Main")

func _ready():
	$SpriteHighlighted.visible = false
	pass
		

func _process(delta):
	$SpriteSelected.visible = self == main.selected_junction
	pass
	
	
func set_curve_point():
	var train_line = self.get_parent()
	var point_idx = train_line.junctions.find(self)
	var curve:Curve2D = self.get_parent().curve
	curve.set_point_position(point_idx, self.position)
	
	self.get_parent().update() # redraw the track
	pass
	

func _on_Area2D_mouse_entered():
	$SpriteHighlighted.visible = true
	pass


func _on_Area2D_mouse_exited():
	$SpriteHighlighted.visible = false
	pass
