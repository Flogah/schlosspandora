extends State
class_name IdleState

func enter(previous_state_path: String, data := {}) -> void:
	get_tree().create_timer(randf_range(1.5, 2.5)).timeout.connect(wander)

func physics_update(_delta: float) -> void:
	owner.velocity = Vector3(0,0,0)
	owner.move_and_slide()

func wander():
	finished.emit("WanderingState")
