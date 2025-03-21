#https://github.com/Chevifier/ChevifierTutorials/blob/main/DiegeticUITutorial/Better%20Implementation/Area3D.gd
extends Area3D

@onready var sprite3d: Sprite3D = $Sprite3D
@onready var viewport: SubViewport = $Sprite3D/SubViewport

func _unhandled_input(event):
	if event is InputEventMouse:
		# Handled via _on_input_event.
		return
	viewport.push_input(event)

func _on_input_event(_camera: Camera3D, event: InputEvent, pos: Vector3, _normal: Vector3, _shape_idx: int):
	# Position of the event in Sprite3D local coordinates.
	var texture_3d_position = sprite3d.get_global_transform().affine_inverse() * pos
	#if !is_zero_approx(texture_3d_position.z):
	if !(texture_3d_position.z < 0.01 and texture_3d_position.z > -0.01): #bigger tolerances bc of the small scale
		# Discard event because event didn't happen on the side of the Sprite3D.
		return
	# Position of the event relative to the texture.
	var texture_position: Vector2 = Vector2(texture_3d_position.x, -texture_3d_position.y) / sprite3d.pixel_size - sprite3d.get_item_rect().position
	# Send mouse event.
	var e: InputEvent = event.duplicate()
	if e is InputEventMouse:
		e.set_position(texture_position)
		e.set_global_position(texture_position)
		viewport.push_input(e)


func _on_quit_button_down() -> void:
	GameManager.request_quit()
