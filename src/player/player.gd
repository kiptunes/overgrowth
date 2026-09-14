extends CharacterBody2D

@export var speed: float = 50.0
@export var jump_vel: float = -100.0
@export var gravity: float = 280.0

var level_solved: bool = false

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var walk_particles: CPUParticles2D = $Particles/WalkParticles

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump_vel
		sprite.play("jump")

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_sprite()

func update_sprite() -> void:
	if abs(velocity.x) > 0.2:
		sprite.flip_h = velocity.x < 0
	
	if is_on_floor():
		if abs(velocity.x) > 0:
			sprite.play("move")
			walk_particles.emitting = true
		else:
			sprite.play("idle")
			walk_particles.emitting = false
	else:
		if velocity.y > 0 and sprite.animation != "fall":
			sprite.play("fall")
		walk_particles.emitting = false
