extends InteractArea

signal level_complete

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var particles: CPUParticles2D = $CPUParticles2D

var locked: bool = true

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("accept") and player_overlapping() and not locked:
		level_complete.emit()
	if not locked:
		sprite.play("open")

func open() -> void:
	sprite.play("open")
	particles.emitting = true
	locked = false

func close() -> void:
	sprite.play("closed")
	locked = true

func player_overlapping() -> bool:
	for body in get_overlapping_bodies():
		if body.is_in_group(PLAYER):
			return true
	return false
