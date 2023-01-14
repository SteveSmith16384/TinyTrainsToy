extends PathFollow2D

const SPEED = 40
const MONEY_PER_PASSENGER = 8

onready var main = get_tree().get_root().get_node("Main")

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
	if main.game_is_over:
		return
		
	main.money -= delta
	if main.money <= 0:
		main.game_over()
		return
	
	if wait_for > 0:
		wait_for -= delta
		return
		
	if num_colliding_trains == 0:
		offset += delta * SPEED * dir
		if dir == 1 and unit_offset >= .99: # todo - check if closer, not .99!
			var pos = get_parent().curve.get_point_position(0)
			var dist = pos.distance_to(self.position)
			if dist < 40:
				unit_offset = 0
			else:
				dir = -1
		elif dir == -1 and unit_offset <= 0.01: # todo - check if closer, not .01!
			var curve: Curve2D = get_parent().curve
			var pos = curve.get_point_position(curve.get_point_count()-1)
			var dist = pos.distance_to(self.position)
			if dist < 40:
				unit_offset = 1
			else:
				dir = 1
	pass


func _on_Area2D_area_entered(area):
	var parent = area.get_parent()
	if area.get_parent() == self:
		return
		
	if parent.is_in_group("stations"):
		$Audio_Arrive.play()
		
		var waiting = false
		var station = parent
		
		# Alight carried passengers
		var new_passenger_list = []
		for idx in passengers.size():
			if passengers[idx] != station.colour:
				# Staying on the train
				new_passenger_list.push_back(passengers[idx])
			else:
				waiting = true
				main.money += MONEY_PER_PASSENGER
				#wait_for += 0.5
		passengers = new_passenger_list

		# Embark new passengers
		#wait_for += parent.passengers.size() / 2

		var space = 6-passengers.size() # Max 6!
		if space > 0:
			for num in space:
				if station.passengers.size() > 0:
					var p = station.passengers.pop_back()
					passengers.push_back(p)
					waiting = true
				else:
					break
			station.update_passenger_list()
		
		if waiting:
			wait_for = 1
#		passengers.append_array(station.passengers)
		#station.clear_passengers()
		$PassengerList.update()
		
	elif parent.is_in_group("trains"):
		if parent.get_parent() != self.get_parent(): # Only collide with trains on diff tracks
			if self.priority < parent.priority:
				num_colliding_trains += 1
				wait_for = 3
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
