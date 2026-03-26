extends State
class_name ChasingState

@onready var navigation_agent_3d: NavigationAgent3D = %NavigationAgent3D
@onready var vision_cone: Node3D = %VisionCone

var target: Node3D

func enter(previous_state_path: String, data := {}) -> void:
	target = data["target"]
	if !target:
		finished.emit("IdleState")
	navigation_agent_3d.set_target_position(target.global_position)

func physics_update(_delta: float) -> void:
	if target:
		vision_cone.look_at(target.global_position)
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
	vision_cone.rotation = Vector3.ZERO
	owner.velocity = Vector3.ZERO

func reached():
	finished.emit("DevouringState")
