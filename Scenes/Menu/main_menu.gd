extends CanvasLayer

@export var starting_scene: PackedScene

@onready var button_start: Button = %ButtonStart
@onready var button_credits: Button = %ButtonCredits
@onready var button_quit: Button = %ButtonQuit
@onready var button_back: Button = %ButtonBack
@onready var credits: Control = %Credits
@onready var menu: Control = %Menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	button_quit.pressed.connect(func(): get_tree().quit())
	button_credits.pressed.connect(get_credits)
	button_back.pressed.connect(back_to_menu)
	button_start.pressed.connect(func(): get_tree().change_scene_to_packed(starting_scene))

func get_credits():
	menu.hide()
	credits.show()

func back_to_menu():
	credits.hide()
	menu.show()
