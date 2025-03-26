extends Node3D

func _ready() -> void:
	$TrainAnimationPlayer.play("TrainAnimation/default")
	$AmbientPlayer.play()

func on_quit_animation_finish(anim_name: StringName):
	if(anim_name == &"Quit"):
		get_tree().quit()
