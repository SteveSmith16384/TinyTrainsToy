extends Path2D


func _ready():
	curve.add_point(Vector2(20, 20))
	curve.add_point(Vector2(50, 30))
	curve.add_point(Vector2(70, 90))
	curve.add_point(Vector2(20, 20))
	
	$TileMap.set_cell(0, 0, 0)
	pass
