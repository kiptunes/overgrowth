extends Node2D

@onready var level_scene: Level
@onready var player: CharacterBody2D = $Player

func get_level_num() -> int:
	var level_num: int = 0
	for child in get_children():
		if child.name.begins_with("Lvl"):
			level_num = int(child.name.right(1))
			break
	return level_num

func reset_level() -> void:
	for c in get_children():
		if c.is_class("Level"):
			level_scene = c
			break
	player.position = level_scene.respawn_point
