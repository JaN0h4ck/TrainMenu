extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pressed.connect(btn_pressed)

func btn_pressed():
	print("pressed")
