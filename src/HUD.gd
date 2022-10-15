extends CanvasLayer


func _ready():
	self.set_status_text("HELLO, NEW CONTROLLER!")
	pass
	
	
func set_status_text(s:String):
	$CenterContainer/Label.text = s
	pass
	
