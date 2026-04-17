extends State
class_name InvestigatingState

@onready var navigation_agent_3d: NavigationAgent3D = %NavigationAgent3D
@onready var timer_vision: Timer = %TimerVision

var investigation_point: Vector3

func enter(previous_state_path: String, data := {}) -> void:
	investigation_point = data["last_noise"]
	if !investigation_point:
		finished.emit("IdleState")
	timer_vision.timeout.connect(visual_scan)
	navigation_agent_3d.set_target_position(investigation_point)
	
	
	
	print("Enter Investigation State, checking at " + str(investigation_point))

func physics_update(_delta: float) -> void:
	if !owner.can_move:
		return
	var destination = navigation_agent_3d.get_next_path_position()
	owner.target = destination
	var local_destination = destination - owner.global_position
	var direction = local_destination.normalized()
	var new_velocity = direction * owner.chase_speed * 0.5
	
	owner.velocity = new_velocity
	owner.move_and_slide()

func exit():
	timer_vision.timeout.disconnect(visual_scan)

func visual_scan():
	if owner.check_for_player():
		finished.emit("ChasingState")
	else:
		return
	
