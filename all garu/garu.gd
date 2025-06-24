extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0
const MAX_JUMPS = 2
var jumps_left = MAX_JUMPS

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	var direction = 0

	# Left/Right input
	if Input.is_action_pressed("move_right"):
		direction += 1
	if Input.is_action_pressed("move_left"):
		direction -= 1

	velocity.x = direction * SPEED

	# Flip sprite and play walk animation
	if direction > 0:
		sprite.flip_h = true
		sprite.play("walk_left")
	elif direction < 0:
		sprite.flip_h = false
		sprite.play("walk_left")
	else:
		sprite.play("idle")

	# Reset jumps when grounded
	if is_on_floor():
		jumps_left = MAX_JUMPS

	# Double jump
	if Input.is_action_just_pressed("jump") and jumps_left > 0:
		velocity.y = JUMP_VELOCITY
		jumps_left -= 1

	# Apply gravity
	if not is_on_floor():
		velocity.y += 1000 * delta

	# Move with built-in velocity
	move_and_slide()
