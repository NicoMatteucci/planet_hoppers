#player.gd
extends CharacterBody2D

@export var velocidad := 100.0
@export var aceleracion := 300.0
@export var rotacion_vel := 3.0

@onready var spaceships = [
	"res://assets/sprites/spaceship_100.png", # 4 vidas
	"res://assets/sprites/spaceship_67.png",  # 3
	"res://assets/sprites/spaceship_33.png",  # 2
	"res://assets/sprites/spaceship_1.png",   # 1
]
@onready var spaceships_node := get_node_or_null("sprite") # asegúrate del nombre real del nodo

func _ready():
	# 1) Grupo para identificar al jugador en colisiones
	add_to_group("player")

	# 3) Textura inicial y reacción a cambios de vida
	if spaceships_node:
		update_spaceship_texture(game.lives)
		if not game.lives_changed.is_connected(update_spaceship_texture):
			game.lives_changed.connect(update_spaceship_texture)

func update_spaceship_texture(new_lives: int) -> void:
	var index = clamp(spaceships.size() - new_lives, 0, spaceships.size() - 1)
	spaceships_node.texture = load(spaceships[index])

func _physics_process(delta):
	var direccion := Vector2.ZERO
	if Input.is_action_pressed("ui_accept"):
		direccion = Vector2.RIGHT.rotated(rotation)
		velocity += direccion * aceleracion * delta
	if Input.is_action_pressed("ui_right"):
		rotation += rotacion_vel * delta
	elif Input.is_action_pressed("ui_left"):
		rotation -= rotacion_vel * delta
	velocity = velocity.limit_length(velocidad)
	move_and_slide()

func rebote(punto_colision: Vector2):
	var normal := (global_position - punto_colision).normalized()
	velocity = velocity.bounce(normal) * 0.8
