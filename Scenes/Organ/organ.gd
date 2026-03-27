extends Node3D
class_name Organ

@export var kill_door: Node3D

@export var organ: Node3D
@export var reste: Node3D

func _ready() -> void:
	reste.visible = false

func _process(delta: float) -> void:
	if kill_door: 
		kill_door.locked.connect(die)
		kill_door = null

func die() -> void:
	if reste and organ:
		reste.visible = true
		organ.visible = false
	
	
