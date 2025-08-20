extends Node2D

@export var velocidad := 100.0  # píxeles por segundo
@export var rotacion := 30.0    # grados por segundo
@export var radio := 32.0

func _ready():
	$CollisionShape2D.shape = CircleShape2D.new()
	$CollisionShape2D.shape.radius = radio
	connect("body_entered", Callable(self, "_on_body_entered"))
	
	# Escalar colisión según sprite
	var escala := scale.x
	$CollisionShape2D.scale = Vector2(escala, escala)
	$CollisionShape2D.shape.radius = radio * escala

func _on_body_entered(body):
	if body.name == "jugador":
		body.rebote(global_position)
		game.lives -= 1
		print("¡Colisión con asteroide! Vidas restantes: %d" % game.lives)

func _process(delta):
	# Movimiento hacia abajo
	position.y += velocidad * delta
	# Rotación suave
	rotation_degrees += rotacion * delta

	# Autodestrucción si sale de pantalla
	if position.y > get_viewport_rect().size.y + 100:
		queue_free()
