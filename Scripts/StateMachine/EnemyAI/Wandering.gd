extends State
class_name WanderingState

@onready var navigation_agent_3d: NavigationAgent3D = %NavigationAgent3D

func enter(previous_state_path: String, data := {}) -> void:
	var random_position = Vector3(randf_range(-5.0, 5.0), 0, randf_range(-5.0, 5.0))
	navigation_agent_3d.set_target_position(random_position)
	
	print("Enter Wandering State, wandering to " + str(random_position))

func physics_update(_delta: float) -> void:
	var destination = navigation_agent_3d.get_next_path_position()
	owner.target = destination
	var local_destination = destination - owner.global_position
	var direction = local_destination.normalized()
	var new_velocity = direction * owner.chase_speed * 0.5
	
	owner.velocity = new_velocity
	owner.move_and_slide()

func exit():
	owner.velocity = Vector3.ZERO

func reached():
	finished.emit("IdleState")
