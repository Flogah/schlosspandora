extends State
class_name IdleState

@onready var timer_vision: Timer = %TimerVision

func enter(previous_state_path: String, data := {}) -> void:
	#get_tree().create_timer(randf_range(1.5, 2.5)).timeout.connect(wander)
	timer_vision.timeout.connect(visual_scan)
	#print("Enter Idle State")

func physics_update(_delta: float) -> void:
	owner.velocity = Vector3(0,0,0)
	owner.move_and_slide()

func exit():
	timer_vision.timeout.disconnect(visual_scan)


func wander():
	finished.emit("WanderingState")

func visual_scan():
	if owner.check_for_player():
		finished.emit("ChasingState")
	else:
		return
