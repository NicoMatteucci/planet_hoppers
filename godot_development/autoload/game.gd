#game.gd
extends Node2D

signal lives_changed(new_lives)

var score := 0
var lives := 4

func lose_life() -> void:
	lives = clamp(lives - 1, 0, 4)
	emit_signal("lives_changed", lives)
	actualizar_lives()
	
func actualizar_lives():
	var hearts = ""
	for i in range(lives):
		hearts += "❤️"  # Podés cambiar por 💚, 💙 o el que te guste
	game_lives_label.text = hearts

	
	if lives <= 0:
		game_over()

func game_over():
	$player.queue_free()
	if game_over_label:
		game_over_label.visible = true
		print("¡GAME OVER!")

	get_tree().paused = true

func _on_TouchScreenButton_pressed():
	print("¡Botón presionado!")

@onready var timer := Timer.new()
@onready var game_over_label = get_node("/root/main/game_over_canvas_layer/game_over_label")
@onready var game_lives_label = get_node("/root/main/game_over_canvas_layer/game_lives_label")


func crear_asteroide():
	var asteroide := preload("res://scenes/asteroid.tscn").instantiate()
	var viewport_size := get_viewport_rect().size
	var spawn_pos: Vector2
	var margin := 200
	
	# Determina el lado de la pantalla por donde aparecerá el asteroide.
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

	asteroide.global_position = spawn_pos
	
	# Ahora el asteroide se dirige a un punto aleatorio dentro de la pantalla.
	var target_pos := Vector2(randf_range(0, viewport_size.x), randf_range(0, viewport_size.y))
	var direccion: Vector2 = (target_pos - asteroide.global_position).normalized()
	
	var velocidad_aleatoria := randf_range(100, 200)
	# Se usa linear_velocity para que el RigidBody2D se mueva con la física.
	asteroide.linear_velocity = direccion * velocidad_aleatoria
	
	var escala := randf_range(0.05, 0.1)
	asteroide.scale = Vector2(escala, escala)
	
	add_child(asteroide)
	move_to_front()
 
func _on_timer_timeout():
	crear_asteroide()

func _ready():
	randomize()
	game_over_label.visible = false
	game_lives_label.visible = true
	actualizar_lives()
	var viewport_size := get_viewport_rect().size
	
	var space := preload("res://scenes/space.tscn").instantiate()
	add_child(space)
	
	var plyr := preload("res://scenes/player.tscn").instantiate()
	plyr.position = viewport_size / 2
	plyr.position.y = viewport_size.y -30
	plyr.velocity = Vector2(0,-50)
	add_child(plyr)
	
	var controles_scene := preload("res://scenes/controls.tscn")
	var controles := controles_scene.instantiate()
	add_child(controles)
	
	timer.wait_time = 0.25
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start()
