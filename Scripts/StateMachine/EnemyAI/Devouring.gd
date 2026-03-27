extends State
class_name DevouringState

func enter(previous_state_path: String, data := {}) -> void:
	devour()

func devour():
	print("GAME OVER")
	var player: Player = get_tree().get_first_node_in_group("Player")
	player.game_over()
