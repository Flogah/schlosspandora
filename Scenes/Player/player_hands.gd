extends Area3D
class_name PlayerHands

var closest_interactable: InteractionComponent

var multiple_interactables: bool = false

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _process(delta: float) -> void:
	if multiple_interactables:
		var closest
		var closest_dist
		for area in get_overlapping_areas():
			if !closest: 
				closest = area
				closest_dist = area.global_position.distance_to(self.global_position)
			else:
				var dist = area.global_position.distance_to(self.global_position)
				if dist < closest_dist:
					closest = area
					closest_dist = dist
		closest_interactable = closest
	if closest_interactable:
		if Input.is_action_just_pressed("interact"):
			print("try open")
			closest_interactable.interact(false)
		if Input.is_action_just_pressed("lock"):
			print("try lock")
			closest_interactable.interact(true)

func _on_area_entered(area: Area3D) -> void:
	if closest_interactable == null:
		closest_interactable = area
	else:
		multiple_interactables = true

func _on_area_exited(area: Area3D) -> void:
	var areas = get_overlapping_areas()
	if areas == []:
		closest_interactable = null
		multiple_interactables = false
	elif areas.size() == 1:
		closest_interactable = areas[0]
		multiple_interactables = false
		
