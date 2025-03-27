extends HSlider

@export
var bus_name: StringName = &""
@export
var setting_key: String = ""

var bus_index: int

func _ready() -> void:
	if(bus_name == &""):
		push_error("Audio Bus name not set!")
		return
	bus_index = AudioServer.get_bus_index(bus_name)
	value_changed.connect(_on_value_changed)
	drag_ended.connect(_on_drag_ended)
	value = GameManager.get_audio_setting(setting_key)

func _on_value_changed(_value: float) -> void:
	AudioServer.set_bus_volume_db(
		bus_index,
		linear_to_db(_value)
	)

func _on_drag_ended(_value_changed: bool) -> void:
	if not _value_changed:
		return
	GameManager.save_volume_setting(setting_key, value)
