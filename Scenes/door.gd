extends Node3D
class_name Door

var is_locked: bool = false
var on_front: bool = false

func lock_door(front: bool) -> void:
	is_locked = true
	on_front = front

func open_door(front: bool) -> void:
	if not is_locked:
		pass
