extends InteractArea

signal player_death

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group(PLAYER):
		player_death.emit()
