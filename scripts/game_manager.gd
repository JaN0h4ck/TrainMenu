#Autoload script to manage important stuff and so on
extends Node

var quit_queued: bool = false
var settings_queued: bool = false
var anim_player: AnimationPlayer

var config = ConfigFile.new()
const SETTINGS_PATH: String = "user://settings.cfg"

enum states {idling, quitting, settings, reverse_setting, ticket}

var current_state: states = states.idling

signal state_changed(state: states)

var master_bus_idx: int
var sfx_bus_idx: int
var music_bus_idx: int

func _ready() -> void:
	master_bus_idx = AudioServer.get_bus_index("Master")
	sfx_bus_idx = AudioServer.get_bus_index("SFX")
	music_bus_idx = AudioServer.get_bus_index("Music")
	
	anim_player = get_tree().root.get_node("/root/MainContainer/SubViewportContainer/SubViewport/Main/AnimationPlayer")
	if(anim_player == null):
		push_error("Anim Tree reference isn't set!")
	else:
		anim_player.connect(&"animation_finished", on_animation_finish)
	if FileAccess.file_exists(SETTINGS_PATH):
		if config.load(SETTINGS_PATH):
			AudioServer.set_bus_volume_db(master_bus_idx, linear_to_db(config.get_value("audio", "master_volume", 1.0)))
			AudioServer.set_bus_volume_db(sfx_bus_idx, linear_to_db(config.get_value("audio", "sfx_volume", 1.0)))
			AudioServer.set_bus_volume_db(music_bus_idx, linear_to_db(config.get_value("audio", "music_volume", 1.0)))
			#setting fullscreen needs to be done in scene by manager bc of the viewport rezise callback
	else:
		config.set_value("video", "fullscreen", false)
		config.set_value("video", "borderless", false)
		
		config.set_value("audio", "master_volume", 1.0)
		config.set_value("audio", "sfx_volume", 1.0)
		config.set_value("audio", "music_volume", 1.0)
		config.save(SETTINGS_PATH)

func save_video_setting(key: String, _value):
	config.set_value("video", key, _value)
	config.save(SETTINGS_PATH)

func save_volume_setting(key: String, _value: float):
	config.set_value("audio", key, _value)
	config.save(SETTINGS_PATH)

func get_audio_setting(key: String) -> float:
	return config.get_value("audio", key, 1.0)

func get_video_setting_bool(key: String) -> bool:
	return config.get_value("video", key, false)

func on_animation_finish(anim_name: StringName):
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if(anim_name == &"Settings"):
		current_state = states.settings
		state_changed.emit(current_state)
	if(anim_name == &"ReverseSettings"):
		current_state = states.idling
		state_changed.emit(current_state)

func request_quit():
	if current_state != states.idling:
		return
	current_state = states.quitting
	state_changed.emit(current_state)
	quit_queued = true
	anim_player.play(&"Quit")

func request_settings() -> bool:
	if current_state != states.idling:
		return false
	if settings_queued:
		return false
	anim_player.play(&"Settings")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	return true

func request_ticket() -> bool:
	if current_state != states.idling:
		return false
	anim_player.play(&"ticket_machine")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	return true

func request_settings_to_idle() -> bool:
	if current_state == states.settings:
		current_state = states.reverse_setting
		state_changed.emit(current_state)
		anim_player.play(&"ReverseSettings")
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		return true
	return false
