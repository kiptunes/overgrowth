extends InteractArea

signal key_collected
@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(PLAYER):
		sprite.play("collect")
		await sprite.animation_finished
		key_collected.emit()
