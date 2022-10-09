extends Node2D

var num_passengers:int = 0

func _ready():
	pass


func _on_NewPassengerTimer_timeout():
	num_passengers += 1
	$Label.text = str(num_passengers)
	pass
