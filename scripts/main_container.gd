extends Control

var viewport_initial_size: Vector2
@onready var viewport: SubViewport = $SubViewportContainer/SubViewport

func _ready():
	get_viewport().size_changed.connect(_root_viewport_size_changed)
	viewport_initial_size = viewport.size
	if GameManager.get_video_setting_bool("fullscreen"):
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		viewport.size = get_viewport().size
		if GameManager.get_video_setting_bool("borderless"):
			DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)

func _root_viewport_size_changed():
	viewport.size = get_viewport().size
