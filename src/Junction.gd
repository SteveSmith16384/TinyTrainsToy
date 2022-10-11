extends Node2D

var point_idx : int


func set_curve_point():
	var curve:Curve2D = self.get_parent().curve
	curve.set_point_position(point_idx, self.position)
	pass
	
	
