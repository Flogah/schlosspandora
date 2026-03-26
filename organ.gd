extends Node3D
class_name Organ

@export var kill_door: Door

@export var organ: Node3D
@export var reste: Node3D

func _ready() -> void:
	reste.visible = false

func _process(delta: float) -> void:
	if kill_door: 
		kill_door.locked.connect(die)
		kill_door = null

func die() -> void:
	reste.visible = true
	organ.visible = false
	
	
