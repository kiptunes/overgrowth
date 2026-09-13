extends InteractArea

signal level_complete

@onready var sprite: Sprite2D = $Sprite2D
@onready var particles: CPUParticles2D = $CPUParticles2D

var locked: bool = true
var open_texture: Texture2D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("up") and player_overlapping() and not locked:
		level_complete.emit()
	if not locked:
		pass
		# open_texture =  = load('res://ass')
		# sprite.texture = open_texture

func open() -> void:
	# open_texture =  = load('res://ass')
	# sprite.texture = open_texture
	particles.emitting = true
	locked = false
	

func player_overlapping() -> bool:
	for area in get_overlapping_areas():
		if area.is_in_group(PLAYER):
			return true
	return false
