#gdscript_test.gd
extends Node2D

# Desde cualquier script
func _on_asteroid_hit():
	game.lives -= 1
	game.score += 100
