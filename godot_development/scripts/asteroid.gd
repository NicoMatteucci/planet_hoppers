#asteroid.gd
extends RigidBody2D

@export var rotacion := 30.0 # grados por segundo
@export var radio := 200.0
var velocity := Vector2.ZERO # Agrega esta variable para recibir la velocidad
@export var margin := 200 # Margen en píxeles

func _ready():
	var collision_shape = get_node_or_null("CollisionShape2D")
	var escala := randf_range(.05, .5)
	if collision_shape:
		# Si se encuentra, configura la colisión.
		collision_shape.shape = CircleShape2D.new()
		collision_shape.scale = Vector2(escala, escala)
		print("Asteroide de escala: ", collision_shape.scale)
		collision_shape.shape.radius *= escala
		print("Asteroide de radio: ", collision_shape.shape.radius)
	else:
		# Si no se encuentra, muestra un error claro para ayudarte a depurar.
		print("ERROR: No se encontró el nodo 'CollisionShape2D' en el asteroide.")
	
	var sprite_node = get_node_or_null("Sprite2D")
	if sprite_node:
		# Aplica la escala del asteroide al sprite.
		# La escala del nodo raíz del asteroide ya se asignó en game.gd.
		sprite_node.scale = Vector2(escala, escala)
	else:
		print("ADVERTENCIA: No se encontró el nodo 'Sprite2D' en el asteroide. La visualización podría no funcionar correctamente.")
	
	var viewport_size := get_viewport_rect().size
	print("viewport_size_x: ", viewport_size.x)
	print("viewport_size_y: ", viewport_size.y)
	var spawn_pos: Vector2
	# Determina el lado de la pantalla por donde aparecerá el asteroide.
	# Añadimos un margen para que aparezca fuera de la vista.
	
	var side := randi_range(0, 3)
	
	if side == 0: # Lado superior
		spawn_pos.x = randf_range(-margin, viewport_size.x + margin)
		spawn_pos.y = -margin
	elif side == 1: # Lado derecho
		spawn_pos.x = viewport_size.x + margin
		spawn_pos.y = randf_range(-margin, viewport_size.y + margin)
	elif side == 2: # Lado inferior
		spawn_pos.x = randf_range(-margin, viewport_size.x + margin)
		spawn_pos.y = viewport_size.y + margin
	else: # Lado izquierdo
		spawn_pos.x = -margin
		spawn_pos.y = randf_range(-margin, viewport_size.y + margin)

	global_position = spawn_pos
	print("Asteroide instanciado en posición: ", global_position)
	
	# Asegura que el asteroide se dirija hacia la pantalla.
	# Calcula la dirección desde el punto de aparición hacia el centro.
	var target_pos := Vector2((viewport_size.x/2), (viewport_size.y/2))
	var direccion: Vector2 = (target_pos-global_position).normalized()
	print("Asteroide con direccion: ", direccion)
	
	var velocidad_aleatoria := randf_range(.1, 1)
	velocity = direccion * velocidad_aleatoria
	print("Asteroide con velocidad: ", velocity)
	
	
	if is_connected("body_entered", _on_body_entered):
		print("¡Error en colision!")
	else:
		connect("body_entered", Callable(self, "_on_body_entered"))
	

func _on_body_entered(body):
	print("¡Colisión con %s!" % body.name)
	if body.name == "jugador":
		body.rebote(global_position)
		game.lives -= 1
		print("¡Colisión con asteroide! Vidas restantes: %d" % game.lives)

func _process(delta):

	# Autodestrucción si sale de pantalla
	var viewport_size := get_viewport_rect().size
	var out_bottom_side = global_position.y > (viewport_size.y + (margin*2))
	var out_top_side = global_position.y < (-(margin*2))
	var out_left_side = global_position.x < (-(margin*2))
	var out_right_side = global_position.x > (viewport_size.x + (margin*2))
	if out_bottom_side or out_top_side or out_left_side or out_right_side:
		print("Asteroide fuera de pantalla x: ", global_position.x)
		print("Asteroide fuera de pantalla y: ", global_position.y)
		print("out_bottom_side: ", out_bottom_side)
		print("out_top_side: ", out_top_side)
		print("out_left_side: ", out_left_side)
		print("out_right_side: ", out_right_side)
		queue_free()
	else:
		# Movimiento del asteroide usando la velocidad asignada
		global_position += velocity * delta
		# Rotación suave
		rotation_degrees += rotacion * delta
	
