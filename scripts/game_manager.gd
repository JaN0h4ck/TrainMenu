#Autoload script to manage important stuff and so on
extends Node

var quit_queued: bool = false
var anim_player: AnimationPlayer

func _ready() -> void:
	anim_player = get_tree().root.get_node("/root/Main/AnimationPlayer")
	if(anim_player == null):
		push_error("Anim Tree reference isn't set!")

func request_quit():
	print("quit requested")
	if quit_queued:
		return
	quit_queued = true
	anim_player.play(&"Quit")
