extends PathFollow2D

var passengers = []
var num_colliding_trains = 0
var dir: int = 1
var priority : int = 0
var wait_for: float = 0

func _ready():
	priority = Globals.get_next_priority()
	loop = false
	pass

func _process(delta):
	if wait_for > 0:
		wait_for -= delta
		return
		
	if num_colliding_trains == 0:
		offset += delta * 30 * dir
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
		wait_for = 1
		var station = parent
		
		# Alight carried passengers
		var new_list = []
		for idx in passengers.size():
			if passengers[idx] != station.colour:
				new_list.push_back(passengers[idx])
				#wait_for += 0.5
		passengers = new_list

		# Embark new passengers
		#wait_for += parent.passengers.size() / 2

		for num in 6-passengers.size(): # Max 6!
			if station.passengers.size() > 0:
				var p = station.passengers.pop_back()
				passengers.push_back(p)
#		passengers.append_array(station.passengers)
		#station.clear_passengers()

		$PassengerList.update()
		
	elif parent.is_in_group("trains"):
		if parent.get_parent() != self.get_parent(): # Only collide with trains on diff tracks
			if self.priority < parent.priority:
				num_colliding_trains += 1
			pass
	elif parent.is_in_group("obstacles"):
		dir = dir * -1
	pass


func _on_Area2D_area_exited(area):
	var parent = area.get_parent()
	if parent.is_in_group("trains"):
		if parent.get_parent() != self.get_parent(): # Only collide with trains on diff tracks
			if self.priority < parent.priority:
				num_colliding_trains -= 1
	pass
