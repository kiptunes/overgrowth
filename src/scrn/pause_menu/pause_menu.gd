extends Control

@onready var menu: Panel = $Panel
@onready var first_focus: Button = $Panel/MarginContainer/VBoxContainer/ResumeButton

var menu_height : float = 84
var viewport_height : float = 144


var main_menu_path: String = "res://src/scrn/main_menu/mainMenu.tscn"
var level_select_path: String = "res://src/scrn/level_select/levelSelect.tscn"

func on_pause() -> void:
	get_tree().paused = true
	show()
	animate_menu()
	first_focus.grab_focus.call_deferred()

func on_unpause() -> void:
	await animate_menu(false)
	hide()
	get_tree().paused = false

func animate_menu(entering: bool = true):
	var tw_time : float = 0.6
	var pos_y : float = viewport_height - menu_height if entering else viewport_height
	var tween = create_tween().set_pause_mode(Tween.TWEEN_PAUSE_PROCESS).set_trans(Tween.TRANS_BACK)
	tween.tween_property(menu, "position:y", pos_y, tw_time)
	await tween.finished


func _on_resume_button_pressed() -> void:
	Globals.game_conductor.handle_pause()
	on_unpause()


func _on_lvl_select_button_pressed() -> void:
	Globals.game_conductor.change_ui_scene(level_select_path)
	on_unpause()

func _on_quit_button_pressed() -> void:
	Globals.game_conductor.change_ui_scene(main_menu_path)
	on_unpause()
