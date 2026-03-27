extends State
class_name DevouringState

@onready var attack_area: Area3D = %AttackArea

func enter(previous_state_path: String, data := {}) -> void:
	devour()

func devour():
	var overlaps = attack_area.get_overlapping_areas()
	if overlaps.size() > 0:
		print("GAME OVER")
	else:
		finished.emit("IdleState")
