#Autoload script to manage important stuff and so on
extends Node

var quit_queued: bool = false
var settings_queued: bool = false
var anim_player: AnimationPlayer

var config = ConfigFile.new()
const SETTINGS_PATH: String = "user://settings.cfg"

func _ready() -> void:
	anim_player = get_tree().root.get_node("/root/Main/AnimationPlayer")
	if(anim_player == null):
		push_error("Anim Tree reference isn't set!")
	if FileAccess.file_exists(SETTINGS_PATH):
		if config.load(SETTINGS_PATH):
			pass # TODO apply settings (fullscreen, etc)
		else:
			# TODO set default values
			print("Parsing error in config File!")

func request_quit():
	if quit_queued:
		return
	quit_queued = true
	anim_player.play(&"Quit")

func request_settings() -> bool:
	if quit_queued:
		print("quit already qued")
		return false
	if settings_queued:
		return false
	anim_player.play(&"Settings")
	return true
