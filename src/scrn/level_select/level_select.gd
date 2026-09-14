extends Control

@onready var buttons: GridContainer = $CenterContainer/GridContainer
@onready var first_focus: Button = $CenterContainer/GridContainer/Button1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect_buttons()
	first_focus.grab_focus.call_deferred()

func connect_buttons() -> void:
	for b in buttons.get_children():
		b.pressed.connect(on_button_pressed.bind(b))

func on_button_pressed(button: Button) -> void:
	var lvl_num: String = button.name.right(1)
	var lvl_path: String = "res://src/world/levels/lvl_0%s/lvl0%s.tscn" % [lvl_num, lvl_num]
	Globals.game_conductor.change_level(lvl_path)
