extends CanvasLayer

onready var main = get_tree().get_root().get_node("Main")

var instruction_idx:int = 0

var instructions = []

func _ready():
	if Globals.game_mode == Globals.GameMode.Simple:
		instructions.push_back("Press J to build a Junction")
		instructions.push_back("Press J to connect another junction")
		instructions.push_back("Press J once more\nto connect another junction")
		instructions.push_back("Right-click to deselect a junction\nand then J to start a new track")
		instructions.push_back("Press J to connect another junction")
		instructions.push_back("You can drag a junction to move it")
		instructions.push_back("Trains will collect and drop off passengers\nat any station they touch")
		instructions.push_back("Trains can only carry 6 passengers")
		instructions.push_back("Passengers will stay on a train until\nthey get to a station of the same\ncolour as themselves")
		instructions.push_back("Press I to insert a junction\nnext to the selected junction")
		instructions.push_back("Press Del to delete a selected junction")
		instructions.push_back("It's game over if more than\n8 passengers are\nwaiting at a station")
		instructions.push_back("Or if you run out of $$$")
		instructions.push_back("Good luck!")
		$InstructionLabel.text = instructions[0]
	else:
		$InstructionLabel.text = ""
	
	self.set_status_text("HELLO, NEW CONTROLLER!")
	$GameOver.visible = false
	pass
	
	
func _process(_delta):
	$InstructionLabel.rect_position = main.get_local_mouse_position()
	pass
	

func next_instruction():
	instruction_idx += 1
	if instruction_idx < instructions.size():
		$InstructionLabel.text = instructions[instruction_idx]
	else:
		$InstructionLabel.text = ""
	pass
	
	
func set_status_text(s:String):
	$CenterContainer/Label.text = s
	pass
	

func set_money(s: int):
	$VBoxContainer2/Score.text = "MONEY: $" + str(s)
	pass


func set_time(s: int):
	$VBoxContainer2/Time.text = "TIME: " + str(s)
	pass


func set_time_to_next_station(s: int):
	$VBoxContainer2/TimeToNextStation.text = "NEXT STATION IN: " + str(s)
	pass


func set_tracks_left(s: int):
	$VBoxContainer2/TracksLeft.text = "TRACKS LEFT: " + str(s)
	pass


func _on_FullScreen_pressed():
	OS.window_fullscreen = not OS.window_fullscreen
	pass


func show_game_over():
	$GameOver.visible = true
	pass
