extends Area3D
class_name InteractionComponent

@export var hint: String

signal interaction(is_locking: bool)

func interact(is_locking: bool) -> void:
	interaction.emit(is_locking)
