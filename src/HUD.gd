extends CanvasLayer

onready var main = get_tree().get_root().get_node("Main")

func _ready():
	self.set_status_text("HELLO, NEW CONTROLLER!")
	pass
	
	
func set_status_text(s:String):
	$CenterContainer/Label.text = s
	pass
	

func set_money(s: int):
	$VBoxContainer2/Score.text = "MONEY: $" + str(s)
	pass


func _on_BuyTrainButton_mouse_entered():
	main.mouse_over_icons = true
	pass


func _on_BuyTrainButton_mouse_exited():
	main.mouse_over_icons = false
	pass




func _on_BuyTrainButton_pressed():
	main.buy_train()
	pass
