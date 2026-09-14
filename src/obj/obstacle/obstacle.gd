extends InteractArea

signal player_death

@export var horizontal: bool = true
@export var path_length: float = 4 #tiles
@export var speed: float = 1.0 # secs

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	path_length *= TILE_SIZE
	sprite.play("default")
	tween_sprite()

func tween_sprite() -> void:
	var property: String = "position:x" if horizontal else "position:y"
	var pos_i: float = position.x if horizontal else position.y
	var pos_f: float = (position.x if horizontal else position.y) + path_length
	var tween: Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE)
	tween.set_loops(100)
	tween.tween_property(self,property,pos_f,speed).set_delay(0.2)
	tween.tween_property(self,property, pos_i, speed).set_delay(0.2)


func _on_body_entered(body: PhysicsBody2D) -> void:
	if body.is_in_group(PLAYER):
		player_death.emit()
