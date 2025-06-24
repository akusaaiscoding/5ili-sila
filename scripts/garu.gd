extends CharacterBody2D

const SPEED = 200.0
const JUMP_VELOCITY = -300.0
const MAX_JUMPS = 2

@onready var anim = $AnimatedSprite2D

var jumps_done = 0

func _physics_process(delta: float) -> void:
	# Apply gravity
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	else:
		jumps_done = 0  # Reset jump count when on floor

	# Handle jump
	if Input.is_action_just_pressed("jump") and jumps_done < MAX_JUMPS:
		velocity.y = JUMP_VELOCITY
		jumps_done += 1

	# Handle horizontal movement
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	# Flip sprite depending on direction
	if velocity.x != 0:
		anim.flip_h = velocity.x > 0

	# Play animation
	if velocity.x != 0:
		if anim.animation != "walk_left":
			anim.play("walk_left")
	else:
		if anim.animation != "idle":
			anim.play("idle")

	move_and_slide()
