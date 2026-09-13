extends InteractArea

signal jump_collected

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision: CollisionShape2D = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite.play("active")


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group(PLAYER):
		sprite.play("inactive")
		collision.disabled = true
		recharge()
		jump_collected.emit()


func recharge() -> void:
	var recharge_time: float = 3.0 # secs
	await get_tree().create_timer(recharge_time).timeout
	sprite.play("active")
	collision.disabled = false
