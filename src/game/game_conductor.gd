class_name GameConductor
extends Node

@onready var pauseMenu : Control = $UI/PauseMenu
@onready var transition : CanvasLayer = $UI/Transition
@onready var world : Node2D = $World
@onready var ui : Control = $UI

var current_ui_scene: Control
var current_level: Level

var main_menu_path: String = "res://src/scrn/main_menu/mainMenu.tscn"
var level_select_path: String = "res://src/scrn/level_select/levelSelect.tscn"
var lvl_01_path: String = "res://src/world/levels/lvl_01/lvl01.tscn"

func _ready() -> void:
	Globals.game_conductor = self
	current_ui_scene = $UI/MainMenu
	world.process_mode = Node.PROCESS_MODE_DISABLED
	world.hide()
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		handle_pause()

func handle_pause() -> void:
	if get_tree().paused:
		pauseMenu.on_unpause()
	else:
		pauseMenu.on_pause()

func change_ui_scene(new_scene: String, delete: bool = true, keep_running: bool = false) -> void:
	if current_ui_scene != null:
		if delete: 
			current_ui_scene.queue_free()
		elif keep_running: 
			current_ui_scene.hide()
		else:
			ui.remove_child(current_ui_scene)
	var new = load(new_scene).instantiate()
	ui.add_child(new)
	current_ui_scene = new
	world.hide()
	world.set_deferred("process_mode", Node.PROCESS_MODE_DISABLED)

func change_level(new_lvl_path: String = "") -> void:
	var new_lvl_scene: Node
	world.set_deferred("process_mode", Node.PROCESS_MODE_DISABLED)
	await transition.transition(true)
	
	if new_lvl_path == "":
		var lvl_num_str: String = str(world.get_level_num() + 1)
		var lvl_folder: String = "res://src/world/levels/lvl_0"
		var target_scene: String = lvl_folder + "%s/lvl0%s.tscn" % [lvl_num_str, lvl_num_str]
		new_lvl_scene = load(target_scene).instantiate()
	else:
		new_lvl_scene = load(new_lvl_path).instantiate()
	if current_level != null:
		current_level.queue_free()
	
	world.process_mode = Node.PROCESS_MODE_PAUSABLE
	world.add_child(new_lvl_scene)
	world.level_scene = new_lvl_scene
	current_level = new_lvl_scene
	world.show()
	
	if current_ui_scene != null:
		current_ui_scene.queue_free()
	
	await transition.transition(false)
