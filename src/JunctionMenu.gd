extends VBoxContainer

onready var main = get_tree().get_root().get_node("Main")

func _on_SplitJunction_pressed():
	var junction = main.selected_junction
	var trainline = junction.get_parent()
	trainline.call_deferred("insert_junction", junction)
	
	$SplitJunction.accept_event()
	self.visible = false
	pass


func _on_RemoveJunction_pressed():
	var junction = main.selected_junction
	var trainline = junction.get_parent()
	trainline.call_deferred("delete_junction", junction)
	
	$RemoveJunction.accept_event()
	self.visible = false
	pass


func _on_BuyTrain_pressed():
	var junction = main.selected_junction
	var trainline = junction.get_parent()
	trainline.call_deferred("add_train", junction)
	
	$BuyTrain.accept_event()
	self.visible = false
	pass
