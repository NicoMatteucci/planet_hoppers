#asteroid.gd
extends RigidBody2D

@export var rotacion := 30.0 # grados por segundo
@export var radio := 200.0
@export var margin := 400 # Margen en píxeles

func _ready():
	var collision_shape = get_node_or_null("CollisionShape2D")
	var escala := scale.x # Obtiene la escala del nodo raíz (asignada en game.gd)
	if collision_shape:
		# Si se encuentra, configura la colisión.
		collision_shape.shape = CircleShape2D.new()
		collision_shape.scale = Vector2(escala, escala)
		collision_shape.shape.radius *= escala
		print("Asteroide de radio: ", collision_shape.shape.radius)
	else:
		# Si no se encuentra, muestra un error claro para ayudarte a depurar.
		print("ERROR: No se encontró el nodo 'CollisionShape2D' en el asteroide.")
	
	var sprite_node = get_node_or_null("Sprite2D")
	if sprite_node:
		# Aplica la escala del asteroide al sprite.
		sprite_node.scale = Vector2(escala, escala)
	else:
		print("ADVERTENCIA: No se encontró el nodo 'Sprite2D' en el asteroide.")
	
	# Conecta la señal body_entered de forma segura.
	if not is_connected("body_entered", Callable(self, "_on_body_entered")):
		connect("body_entered", Callable(self, "_on_body_entered"))
	
	print("Asteroide instanciado en posición: ", global_position)
	print("Asteroide con velocidad: ", linear_velocity)

func _on_body_entered(body):
	print("¡Colisión con %s!" % body.name)
	if body.name == "jugador":
		body.rebote(global_position)
		game.lives -= 1
		print("¡Colisión con asteroide! Vidas restantes: %d" % game.lives)

func _physics_process(delta):
	# Rotación suave
	rotation_degrees += rotacion * delta

	# Autodestrucción si sale de pantalla
	var viewport_size := get_viewport_rect().size
	var out_bottom_side = global_position.y > (viewport_size.y + margin)
	var out_top_side = global_position.y < (-margin)
	var out_left_side = global_position.x < (-margin)
	var out_right_side = global_position.x > (viewport_size.x + margin)
	if out_bottom_side or out_top_side or out_left_side or out_right_side:
		queue_free()
