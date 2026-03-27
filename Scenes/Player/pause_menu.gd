extends CanvasLayer

const MAIN_MENU = preload("uid://p58txrgg4pw")

@onready var button_exit: Button = %ButtonExit
@onready var game_over: Control = %GameOver
@onready var pause: Control = %Pause
@onready var button_go_back: Button = %ButtonGOBack

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

func show_game_over():
	owner.can_look_around = false
	show()
	pause.hide()
	game_over.show()
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	button_go_back.pressed.connect(load_main_menu)
	
func load_main_menu():
	get_tree().quit()
