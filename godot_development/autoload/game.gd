#game.gd
extends Node2D

var score := 0
var lives := 3

func _ready():
	randomize()
	var plyr := preload("res://scenes/player.tscn").instantiate()
	plyr.position = get_viewport_rect().size / 2
	add_child(plyr)
	
	var controles_scene := preload("res://scenes/controls.tscn")
	var controles := controles_scene.instantiate()
	add_child(controles)
	
	add_child(timer)
	timer.wait_time = 1.0
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)

func _on_TouchScreenButton_pressed():
	print("¡Botón presionado!")

@onready var timer := Timer.new()

func crear_asteroide():
	var asteroide := preload("res://scenes/asteroid.tscn").instantiate()

	# Posición aleatoria fuera de pantalla (por arriba)
	var x := randf_range(100, 980)
	var y := randf_range(200, 50)
	asteroide.global_position = Vector2(x, y)

	# Tamaño aleatorio
	var escala := randf_range(0.05, 0.3)
	asteroide.scale = Vector2(escala, escala)

	# Si usás un radio en el script del asteroide
	if asteroide.has_variable("radio"):
		asteroide.radio *= escala

	add_child(asteroide)

func _on_timer_timeout():
	var cantidad := randi() % 4 + 2  # Entre 2 y 5 asteroides
	for i in cantidad:
		crear_asteroide()
