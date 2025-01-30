extends CharacterBody2D

const SPEED = 50.0
@onready var sprite = $AnimatedSprite2D

var last_direction = Vector2.ZERO  # Armazena a última direção do jogador

func _physics_process(_delta: float) -> void:
	var direction = Vector2.ZERO  # Direção do movimento

	# Captura os inputs de movimento
	if Input.is_action_pressed("key_right"):
		direction.x += 1
	if Input.is_action_pressed("key_left"):
		direction.x -= 1
	if Input.is_action_pressed("key_down"):
		direction.y += 1
	if Input.is_action_pressed("key_up"):
		direction.y -= 1

	# Se houver movimento, atualiza a última direção válida
	if direction != Vector2.ZERO:
		last_direction = direction.normalized()
		velocity = direction * SPEED
		play_run_animation(direction)
	else:
		velocity = Vector2.ZERO  # Isso faz com que o personagem pare
		play_idle_animation()

	move_and_slide()

# Função para animação de idle com base na direção do movimento
func play_idle_animation():
	if last_direction.y > 0:
		sprite.play("idle_front")
	elif last_direction.y < 0:
		sprite.play("idle_back")
	elif last_direction.x < 0:
		sprite.flip_h = true
		sprite.play("idle_left")
	elif last_direction.x > 0:
		sprite.flip_h = false
		sprite.play("idle_left")

# Função para animação de movimento (run)
func play_run_animation(direction):
	if direction.y > 0:
		sprite.play("run_front")
	elif direction.y < 0:
		sprite.play("run_back")
	elif direction.x < 0:
		sprite.flip_h = true
		sprite.play("run_left")
	elif direction.x > 0:
		sprite.flip_h = false
		sprite.play("run_left")
