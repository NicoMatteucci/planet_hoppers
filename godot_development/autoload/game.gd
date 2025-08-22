#game.gd
extends Node2D

var score := 0
var lives := 3

func _on_TouchScreenButton_pressed():
	print("¡Botón presionado!")

@onready var timer := Timer.new()

func crear_asteroide():
	var asteroide := preload("res://scenes/asteroid.tscn").instantiate()
	add_child(asteroide)
	move_to_front()
 
func _on_timer_timeout():
	#print("¡Timer vencido!")
	crear_asteroide()

func _ready():
	randomize()
	var viewport_size := get_viewport_rect().size
	
	var plyr := preload("res://scenes/player.tscn").instantiate()
	plyr.position = viewport_size / 2
	plyr.position.y = viewport_size.y -30
	plyr.velocity = Vector2(0,-50)
	add_child(plyr)
	
	var controles_scene := preload("res://scenes/controls.tscn")
	var controles := controles_scene.instantiate()
	add_child(controles)
	
	# No necesitas add_child(timer), ya que @onready lo hace automáticamente
	timer.wait_time = 1.0
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)
	timer.start()
	#print("¡Fin ready!")
