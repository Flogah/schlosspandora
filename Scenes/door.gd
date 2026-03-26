extends Node3D
class_name Door

@onready var door_l: AnimatableBody3D = $Door_L
@onready var door_r: AnimatableBody3D = $Door_R
@onready var ia_comp_f: InteractionComponent = $IaCompFront
@onready var ia_comp_b: InteractionComponent = $IaCompBack
@onready var lock_f: Node3D = $LockF
@onready var lock_b: Node3D = $LockB

var is_locked: bool = false
var is_closed: bool = true
var lock_side_front: bool = true

func _ready() -> void:
	ia_comp_f.interaction.connect(door_interaction_f)
	ia_comp_b.interaction.connect(door_interaction_b)
	
func door_interaction_f(is_locking: bool):
	door_interaction(is_locking, true)

func door_interaction_b(is_locking: bool):
	door_interaction(is_locking, false)
	
func door_interaction(is_locking: bool, front: bool):
	print("[Door] interaction recieved")
	if is_locking:
		lock_interaction(front)
	else:
		open_close_interaction(front)

func lock_interaction(front: bool) -> void:
	if is_locked and lock_side_front == front: 
		is_locked = false
		hide_lock()
		print("[Door] unlocked")
	elif not is_locked:
		print("[Door] locked")
		show_lock(front)
		is_locked = true
		lock_side_front = front

func open_close_interaction(front: bool) -> void:
	if not is_locked:
		if is_closed:
			is_closed = false
			animate_opening(front)
		else:
			animate_closeing()
			is_closed = true

func animate_locking(front: bool) -> void:
	pass

func animate_unlocking(front: bool) -> void:
	pass

func animate_opening(front: bool) -> void:
	print("[Door] opening")
	var tween = get_tree().create_tween()
	var dir
	if front:
		dir = 90
	else:
		dir = -90
	tween.set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(door_l, "rotation_degrees", Vector3(0, dir, 0), 1.0)
	tween.parallel().tween_property(door_r, "rotation_degrees", Vector3(0, -dir, 0), 1.0)

func animate_closeing() -> void:
	print("[Door] closeing")
	var tween = get_tree().create_tween()
	tween.set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(door_l, "rotation_degrees", Vector3(0, 0, 0), 1.0)
	tween.parallel().tween_property(door_r, "rotation_degrees", Vector3(0, 0, 0), 1.0)

func show_lock(front: bool):
	if front:
		lock_f.visible = true
	else:
		lock_b.visible = true

func hide_lock():
	lock_f.visible = false
	lock_b.visible = false
