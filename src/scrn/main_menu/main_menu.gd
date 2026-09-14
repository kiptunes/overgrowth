extends Control

@onready var first_focus: Button = $MarginContainer/VBoxContainer/Buttons/PlayButton

func _ready() -> void:
	first_focus.grab_focus.call_deferred()


func _on_play_button_pressed() -> void:
	Globals.game_conductor.change_level("res://src/world/levels/lvl_01/lvl01.tscn")


func _on_level_button_pressed() -> void:
	Globals.game_conductor.change_ui_scene("res://src/scrn/level_select/levelSelect.tscn",true,false)
