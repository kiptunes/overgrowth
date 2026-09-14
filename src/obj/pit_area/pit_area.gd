extends InteractArea

signal player_death

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_death.emit()
