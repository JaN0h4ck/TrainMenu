#Autoload script to manage important stuff and so on
extends Node

var quit_queued: bool = false
var settings_queued: bool = false
var anim_player: AnimationPlayer

var config = ConfigFile.new()
const SETTINGS_PATH: String = "user://settings.cfg"

enum states {idling, quitting, settings, reverse_setting}

var current_state: states = states.idling

signal state_changed(state: states)

func _ready() -> void:
	anim_player = get_tree().root.get_node("/root/MainContainer/SubViewportContainer/SubViewport/Main/AnimationPlayer")
	if(anim_player == null):
		push_error("Anim Tree reference isn't set!")
	else:
		anim_player.connect(&"animation_finished", on_animation_finish)
	if FileAccess.file_exists(SETTINGS_PATH):
		if config.load(SETTINGS_PATH):
			pass # TODO apply settings (fullscreen, etc)
		else:
			# TODO set default values
			print("Parsing error in config File!")

func on_animation_finish(anim_name: StringName):
	if(anim_name == &"Settings"):
		current_state = states.settings
		state_changed.emit(current_state)
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	if(anim_name == &"ReverseSettings"):
		current_state = states.idling
		state_changed.emit(current_state)
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func request_quit():
	if quit_queued:
		return
	current_state = states.quitting
	state_changed.emit(current_state)
	quit_queued = true
	anim_player.play(&"Quit")

func request_settings() -> bool:
	if quit_queued:
		print("quit already qued")
		return false
	if settings_queued:
		return false
	anim_player.play(&"Settings")
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
