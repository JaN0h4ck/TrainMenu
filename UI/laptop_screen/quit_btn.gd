extends Button

func _ready() -> void:
	button_down.connect(on_btn_down)

func on_btn_down() -> void:
	GameManager.request_quit()
	visible = false
