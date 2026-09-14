extends CanvasLayer

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	animationPlayer.play("RESET")
	hide()

func transition(fill: bool) -> void:
	var animation = "transition_cover" if fill else "transition_uncover"
	if fill: visible = true
	animationPlayer.play(animation)
	await animationPlayer.animation_finished
	if not fill: visible = false
