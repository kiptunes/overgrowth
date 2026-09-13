extends InteractArea

signal key_collected

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group(PLAYER):
		key_collected.emit()
		queue_free()
