extends State
class_name DevouringState

func enter(previous_state_path: String, data := {}) -> void:
	print("Entering Devouring State")
	# makes this some kind of game over state
