extends CanvasLayer

const MAIN_MENU = preload("uid://p58txrgg4pw")

@onready var button_exit: Button = %ButtonExit
@onready var game_over: Control = %GameOver
@onready var button_go_back: Button = %ButtonGOBack
@onready var hand: Control = %Hand
@onready var pause_menu: Control = %PauseMenu
@onready var animated_sprite_hand: AnimatedSprite2D = $Hand/AnimatedSpriteHand

var has_lock: bool = true

func _ready() -> void:
	button_exit.pressed.connect(func(): get_tree().quit())
	animated_sprite_hand.animation_finished.connect(randomize_idle_hand)

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("pause_menu"):
		if !pause_menu.visible:
			owner.can_look_around = false
			pause_menu.show()
			get_tree().paused = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			owner.can_look_around = true
			get_tree().paused = false
			pause_menu.hide()
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func show_game_over():
	owner.can_look_around = false
	show()
	pause_menu.hide()
	hand.hide()
	game_over.show()
	get_tree().paused = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	button_go_back.pressed.connect(load_main_menu)
	
func load_main_menu():
	get_tree().quit()

func randomize_idle_hand():
	var rand = randi_range(-1, 1)
	
	if !has_lock:
		if rand > 0:
			animated_sprite_hand.play("idle_empty")
		else:
			animated_sprite_hand.play("idle_empty_2")
	
	if rand > 0:
		animated_sprite_hand.play("idle")
	else:
		animated_sprite_hand.play("idle2")

func locking():
	if !has_lock:
		has_lock = true
		animated_sprite_hand.play_backwards("locking")
	
	has_lock = false
	animated_sprite_hand.play("locking")

func interacting():
	animated_sprite_hand.play("interact")
