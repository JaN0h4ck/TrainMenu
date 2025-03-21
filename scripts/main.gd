extends Node3D

func on_quit_animation_finish(anim_name: StringName):
	if(anim_name == &"Quit"):
		get_tree().quit()
