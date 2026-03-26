extends Node3D
class_name Door

@onready var door_l: AnimatableBody3D = $Door_L
@onready var door_r: AnimatableBody3D = $Door_R
@onready var ia_comp_f: InteractionComponent = $IaCompFront
@onready var ia_comp_b: InteractionComponent = $IaCompBack

var is_locked: bool
var is_closed: bool
var lock_side_front: bool

func _ready() -> void:
	ia_comp_f.interaction.connect(door_interaction.bind(true))
	ia_comp_b.interaction.connect(door_interaction.bind(true))

func door_interaction(is_locking: bool, front: bool):
	if is_locking:
		lock_interaction(front)
	else:
		open_close_interaction(front)

func lock_interaction(front: bool) -> void:
	if is_locked and lock_side_front == front: is_locked = false
	else: 
		is_locked = true
		lock_side_front = front

func open_close_interaction(front: bool) -> void:
	if is_closed and not is_locked:
		is_closed = false
		animate_opening(front)
	else:
		animate_closeing()

func animate_locking(front: bool) -> void:
	pass

func animate_unlocking(front: bool) -> void:
	pass

func animate_opening(front: bool) -> void:
	var tween = get_tree().create_tween()
	var dir
	if front:
		dir = 90
	else:
		dir = -90
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(door_l, "rotation_degrees", Vector3(0, dir, 0), 1.0)
	tween.tween_property(door_r, "rotation_degrees", Vector3(0, dir, 0), 1.0)

func animate_closeing() -> void:
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(door_l, "rotation_degrees", Vector3(0, 0, 0), 1.0)
	tween.tween_property(door_r, "rotation_degrees", Vector3(0, 0, 0), 1.0)
