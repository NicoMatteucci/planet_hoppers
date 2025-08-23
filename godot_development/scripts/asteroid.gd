#asteroid.gd
extends RigidBody2D

@export var rotacion := 30.0 # grados por segundo
@export var base_radius := 48.0 # radio base antes de escalar
@export var margin := 400 # Margen en píxeles

func _ready():
	
	# Habilitar monitoreo de contactos para emitir body_entered
	contact_monitor = true
	max_contacts_reported = 8
	
	var collision_shape = $CollisionShape2D
	if collision_shape:
		# Solo aseguramos que existe, no tocamos su shape si ya está bien definido en el editor
		print("Shape del asteroide listo:", collision_shape.shape)

	# Asegurar capas/máscaras para chocar con el jugador
	#    Ejemplo: asteroide en capa 2, colisiona contra capa 1
	collision_layer = 1 << 1      # 2
	collision_mask  = 1 << 0      # 1

	# 4) Conectar señal
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)
			
	print("Asteroide instanciado en posición: ", global_position)
	print("Asteroide con velocidad: ", linear_velocity)

func _on_body_entered(body: Node):
	print("¡Colisión con %s!" % body.name)
	if body.is_in_group("player"):
		if body.has_method("rebote"):
			body.rebote(global_position)
		game.lose_life()
		print("¡Colisión con asteroide! Vidas: %d" % game.lives)

func _physics_process(delta):
	rotation_degrees += rotacion * delta
	var viewport_size := get_viewport_rect().size
	var out := global_position.y > (viewport_size.y + margin) \
		or global_position.y < -margin \
		or global_position.x < -margin \
		or global_position.x > (viewport_size.x + margin)
	if out:
		queue_free()
