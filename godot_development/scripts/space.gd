extends Node2D

@onready var backgrounds = [
	"res://assets/sprites/fondo_nebulosa_homogenea.png",
	"res://assets/sprites/fondo_nerbulosa_alejada.png",
	"res://assets/sprites/fondo_espacial.png",
	"res://assets/sprites/fondo_choque_planetario.png",
	"res://assets/sprites/fondo_radiacion_roja.png",
	"res://assets/sprites/fondo_radiacion_azul.png",
]

@onready var background_node = get_node_or_null("FondoEspacial")

func _ready():
	randomize()
	var viewport_size := get_viewport_rect().size
	# Lógica para seleccionar y establecer el fondo aleatorio
	if background_node:
		var random_bg_path = backgrounds[randi() % backgrounds.size()]
		background_node.texture = load(random_bg_path)
		background_node.position = viewport_size / 2
		# Ajusta la escala para que el fondo se expanda y cubra el viewport
		background_node.scale = Vector2(viewport_size.x / background_node.texture.get_width(), viewport_size.y / background_node.texture.get_height())
		print("Instanciando backgroudn path: ", random_bg_path)
		print("Instanciando position: ", background_node.position)
		print("backgroudn scale: ", background_node.scale)
		
