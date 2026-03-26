extends CharacterBody3D


@export var SPEED = 2.0
var stand_height = 2.0
var crouch_height = 0.5
var cam_stand_height = 0.512
var cam_crouch_height = 0.2
var crouching = false
@export var Sensitivity = 0.001

@onready var head = $Head

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * Sensitivity)
		head.rotate_x(-event.relative.y * Sensitivity)

func _physics_process(delta: float) -> void:
	process_move(delta)
	process_crouch()

func process_crouch() -> void:
	if Input.is_action_just_pressed("crouch"):
		crouching = !crouching
		if crouching:
			$CollisionShape3D.shape.height = crouch_height
			head.position.y = cam_crouch_height
			SPEED = SPEED / 2
		else:
			$CollisionShape3D.shape.height = stand_height
			head.position.y = cam_stand_height
			SPEED = SPEED * 2
		
		print($CollisionShape3D.shape.height)


func process_move(delta: float) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
