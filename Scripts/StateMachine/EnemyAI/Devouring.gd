extends State
class_name DevouringState

func enter(previous_state_path: String, data := {}) -> void:
	devour()

func devour():
	print("GAME OVER")
