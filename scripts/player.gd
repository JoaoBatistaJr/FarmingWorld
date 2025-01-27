extends CharacterBody2D


const SPEED = 70.0
const JUMP_VELOCITY = -400.0


func _physics_process(_delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		pass
		#velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		$AnimatedSprite2D.play("idle_left")
		velocity.x = direction * SPEED
	else:
		$AnimatedSprite2D.play("idle_front")
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
