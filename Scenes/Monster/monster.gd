extends CharacterBody3D

enum side{
	front,
	left,
	right,
	back
}

@export var ai_active: bool = true
@export var can_move: bool = true
@export var aggressive: bool = true


@export var chase_speed: float = 10.0

@export var sprites: Dictionary[side, Texture2D]={
	side.front: null,
	side.left: null,
	side.right: null,
	side.back: null
}

@onready var sprite: Sprite3D = %Sprite3D
@onready var state_machine: StateMachine = %StateMachine
@onready var eye: RayCast3D = %Eye
@onready var vision_cone: Area3D = %VisionCone
@onready var timer_vision: Timer = %TimerVision

var target:Vector3
var can_look: bool = true

func _process(delta: float) -> void:
	if target:
		var bla = Vector3(target.x, position.y, target.z)
		look_at(bla)
	
	adjust_sprite_for_angle()

func adjust_sprite_for_angle():
	var pos_2d = Vector2(position.x, position.z)
	var cam_pos_2d = Vector2(get_viewport().get_camera_3d().global_position.x, get_viewport().get_camera_3d().global_position.z)
	var vec_to_cam: Vector2 = (pos_2d - cam_pos_2d).normalized()
	var cam_angle = rad_to_deg(vec_to_cam.angle_to(Vector2(-transform.basis.z.x, -transform.basis.z.z)))
	
	if cam_angle > 0:
		sprite.texture = sprites[side.front]
		if cam_angle < 135:
			sprite.texture = sprites[side.right]
		if cam_angle < 45:
			sprite.texture = sprites[side.back]
	
	elif cam_angle < 0:
		sprite.texture = sprites[side.back]
		if cam_angle < -45:
			sprite.texture = sprites[side.left]
		if cam_angle < -135:
			sprite.texture = sprites[side.front]

func receive_noise(last_noise: Vector3):
	var data: Dictionary = {"last_noise": last_noise}
	state_machine._transition_to_next_state("InvestigatingState", data)

func check_for_player() -> bool:
	var sighting
	
	var overlaps = vision_cone.get_overlapping_bodies()
	if overlaps.size() > 0:
		for overlap in overlaps:
			if overlap.is_in_group("Player"):
				sighting = overlap
	if !sighting:
		return false
	
	eye.rotation = Vector3.ZERO
	var direction = sighting.global_position.direction_to(eye.global_position)
	eye.target_position = direction * 20.0
	if eye.is_colliding():
		if !eye.get_collider().is_in_group("Player"):
			return false
	return true
