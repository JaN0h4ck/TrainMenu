extends HSlider

@export
var bus_name: StringName = &""

var bus_index: int

func _ready() -> void:
	if(bus_name == &""):
		push_error("Audio Bus name not set!")
		return
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(_on_value_changed)

func _on_value_changed(_value: float) -> void:
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(_value)
	)
	#TODO settings persistence
