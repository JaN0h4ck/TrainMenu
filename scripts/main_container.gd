extends Control

var viewport_initial_size: Vector2
@onready var viewport: SubViewport = $SubViewportContainer/SubViewport

func _ready():
	get_viewport().size_changed.connect(_root_viewport_size_changed)
	viewport_initial_size = viewport.size

func _root_viewport_size_changed():
	viewport.size = get_viewport().size
