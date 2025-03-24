extends Area2D


func _input(event):
	if event is InputEventMouse or event is InputEventScreenDrag or event is InputEventScreenTouch:
		return
	$Sprite2D/SubViewport.push_input(event)


func _on_input_event(_viewport, event, _shape_idx):
	# This line is a hack, that needs to be removed after https://github.com/godotengine/godot/pull/77926 gets merged
	$Sprite2D/SubViewport.handle_input_locally = true
	
	$Sprite2D/SubViewport.push_input(event)

	# This line is a hack, that needs to be removed after https://github.com/godotengine/godot/pull/77926 gets merged
	$Sprite2D/SubViewport.handle_input_locally = false
