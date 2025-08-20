extends Node2D

var score := 0
var lives := 3

func _ready():
	var plyr := preload("res://scenes/player.tscn").instantiate()
	plyr.position = get_viewport_rect().size / 2
	add_child(plyr)
