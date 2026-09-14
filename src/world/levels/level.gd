class_name Level
extends Node2D

const TILE_SIZE = 12.0
@export var respawn_point: Vector2
@export var locked: bool = true
@export var level_num: int

var key: Area2D
var player: CharacterBody2D
@onready var door: Area2D = $Door

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if locked:
		key = $Key
		key.key_collected.connect(_on_key_collected)
	respawn_point *= TILE_SIZE
	door.locked = locked
	door.level_complete.connect(_on_level_completed)
	for c in get_parent().get_children():
		if c.is_in_group("player"):
			player = c
	player.position = respawn_point
	for c in get_children():
		if c.has_signal("player_death"):
			c.player_death.connect(reset_level)

func reset_level() -> void:
	if Globals.game_conductor.transition.animationPlayer.is_playing(): return
	var lvl_num_str: String = str(level_num)
	var lvl_folder: String = "res://src/world/levels/lvl_0"
	var target_scene: String = lvl_folder + "%s/lvl0%s.tscn" % [lvl_num_str, lvl_num_str]
	Globals.game_conductor.change_level(target_scene)

func _on_key_collected() -> void:
	key.hide()
	door.open()

func _on_level_completed() -> void:
	if level_num == 6:
		Globals.game_conductor.change_ui_scene("res://src/scrn/end_scrn/endScreen.tscn")
		return
	var victory_time: float = 2.4
	if not player.is_on_floor():
		while not player.is_on_floor():
			if player.is_on_floor():
				break
			await get_tree().create_timer(0.2).timeout
	player.process_mode = Node.PROCESS_MODE_DISABLED
	player.sprite.process_mode = PROCESS_MODE_PAUSABLE
	player.sprite.play("victory")
	await get_tree().create_timer(victory_time).timeout
	player.process_mode = Node.PROCESS_MODE_INHERIT
	player.sprite.process_mode = PROCESS_MODE_INHERIT
	Globals.game_conductor.change_level()
	
			
