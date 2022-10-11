extends PathFollow2D

var passengers = []
var num_colliding_trains = 0
var dir: int = 1
var priority : int = 0

func _ready():
	priority = Globals.get_next_priority()
	loop = false
	pass

func _process(delta):
	if num_colliding_trains == 0:
		offset += delta * 20 * dir
		if dir == 1 and unit_offset >= .99:
			dir = -1
		elif dir == -1 and unit_offset <= 0.01:
			dir = 1
	pass


func _on_Area2D_area_entered(area):
	var parent = area.get_parent()
	if area.get_parent() == self:
		return
	if parent.is_in_group("stations"):
		# Alight carried passengers
		var new_list = []
		for idx in passengers.size():
			if passengers[idx] != parent.colour:
				new_list.push_back(passengers[idx])
		passengers = new_list

		# Embark new passengers
		passengers.append_array(parent.passengers)
		$PassengerList.update()
		parent.clear_passengers()
	elif parent.is_in_group("trains"):
		if parent.get_parent() != self.get_parent(): # Only collide with trains on diff tracks
			if self.priority < parent.priority:
				num_colliding_trains += 1
			pass
	pass


func _on_Area2D_area_exited(area):
	var parent = area.get_parent()
	if parent.is_in_group("trains"):
		if parent.get_parent() != self.get_parent(): # Only collide with trains on diff tracks
			if self.priority < parent.priority:
				num_colliding_trains -= 1
	pass
