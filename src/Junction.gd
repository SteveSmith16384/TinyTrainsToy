extends Node2D

#var point_idx : int


func set_curve_point():
	var train_line = self.get_parent()
	var point_idx = train_line.junctions.find(self)
	var curve:Curve2D = self.get_parent().curve
	curve.set_point_position(point_idx, self.position)
	
	self.get_parent().update() # redraw the track
	pass
	
	
