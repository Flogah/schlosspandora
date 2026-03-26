extends State
class_name IdleState

func enter(previous_state_path: String, data := {}) -> void:
	await get_tree().create_timer(randf_range(.25, 1.0)).timeout
	finished.emit("WanderingState")
