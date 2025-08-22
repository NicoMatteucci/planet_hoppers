#player.gd
extends CharacterBody2D

@export var velocidad := 100.0
@export var aceleracion := 300.0
@export var rotacion_vel := 3.0
@export var init_status := true

func _physics_process(delta):
	var direccion := Vector2.ZERO

	if Input.is_action_pressed("ui_accept"):  # thrust
		direccion = Vector2.RIGHT.rotated(rotation)
		velocity += direccion * aceleracion * delta

	if Input.is_action_pressed("ui_right"):
		rotation += rotacion_vel * delta
	elif Input.is_action_pressed("ui_left"):
		rotation -= rotacion_vel * delta

	velocity = velocity.limit_length(velocidad)
	move_and_slide()

func rebote(punto_colision: Vector2):
	print("¡Rebote!")
	var normal := (global_position - punto_colision).normalized()
	velocity = velocity.bounce(normal) * 0.8  # Rebote con amortiguación
