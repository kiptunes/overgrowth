extends CharacterBody2D

@export var speed = 300.0
@export var jump_vel = -400.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = jump_vel

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
	update_sprite()

func update_sprite() -> void:
	sprite.flip_h = velocity.x > 0
	
	if is_on_floor():
		if abs(velocity.x) > 0:
			sprite.play("move")
		else:
			sprite.play("idle")
	elif velocity.y < 0:
		sprite.play("jump")
	else:
		sprite.play("fall")
