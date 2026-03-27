extends State
class_name ChasingState

@onready var navigation_agent_3d: NavigationAgent3D = %NavigationAgent3D
@onready var timer_vision: Timer = %TimerVision
@onready var attack_area: Area3D = %AttackArea

var target: Node3D

func enter(previous_state_path: String, data := {}) -> void:
	target = get_tree().get_first_node_in_group("Player")
	navigation_agent_3d.set_target_position(target.global_position)
	print("Entering Chasing State, chasing " + target.name)
	timer_vision.timeout.connect(visual_scan)
	attack_area.body_entered.connect(reached)

func physics_update(_delta: float) -> void:
	if !owner.can_move:
		finished.emit("IdleState")
	
	if target:
		var sighting = owner.check_for_player()
		if sighting:
			navigation_agent_3d.set_target_position(target.global_position)
		else:
			var data: Dictionary= {"last_noise": target.global_position}
			finished.emit("InvestigatingState", data)
	
	var destination = navigation_agent_3d.get_next_path_position()
	owner.target = destination
	var local_destination = destination - owner.global_position
	var direction = local_destination.normalized()
	var new_velocity = direction * owner.chase_speed
	
	owner.velocity = new_velocity
	owner.move_and_slide()

func exit():
	owner.velocity = Vector3.ZERO
	timer_vision.timeout.disconnect(visual_scan)
	attack_area.body_entered.disconnect(reached)

func reached(body):
	finished.emit("DevouringState")

func visual_scan():
	if owner.check_for_player():
		return
	else:
		var data = {"last_noise": target.global_position}
		finished.emit("InvestigatingState", data)
