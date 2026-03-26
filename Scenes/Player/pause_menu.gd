extends CanvasLayer

@onready var button_exit: Button = %ButtonExit

func _ready() -> void:
	hide()
	button_exit.pressed.connect(func(): get_tree().quit())

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("pause_menu"):
		if !visible:
			owner.can_look_around = false
			show()
			get_tree().paused = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			owner.can_look_around = true
			get_tree().paused = false
			hide()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
