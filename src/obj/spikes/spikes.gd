extends InteractArea

signal player_death

@export var length: float = 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var shape: RectangleShape2D = $CollisionShape2D.shape 
	shape.size.x = length * TILE_SIZE


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group(PLAYER):
		player_death.emit()
