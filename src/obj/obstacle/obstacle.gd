extends InteractArea

signal player_death

@export var horizontal: bool = true
@export var path_length: float = 4 #tiles

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	path_length *= TILE_SIZE
	sprite.play("default")
	# tween sprite


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group(PLAYER):
		player_death.emit()
