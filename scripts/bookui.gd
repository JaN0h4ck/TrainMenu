extends Node2D

@onready var settings_btn: Button = $Control/MarginContainer/SettingsBtn
@onready var settings_ui: Control = $Control/MarginContainer/SettingsUI
@onready var borderless: CheckBox = $Control/MarginContainer/SettingsUI/HBoxContainer/Left/Borderless

func _ready() -> void:
	GameManager.state_changed.connect(_on_gm_state_changed)
	settings_btn.visible = true
	settings_ui.visible = false
	borderless.disabled = true
	$Control/MarginContainer/SettingsUI/HBoxContainer/Left/FullScreen.button_pressed = GameManager.get_video_setting_bool("fullscreen")
	$Control/MarginContainer/SettingsUI/HBoxContainer/Left/Borderless.button_pressed = GameManager.get_video_setting_bool("borderless")

func _on_gm_state_changed(new_state: GameManager.states)-> void:
	if new_state == GameManager.states.reverse_setting:
		settings_btn.visible = true
		settings_ui.visible = false

func _on_settings_btn_pressed() -> void:
	if GameManager.request_settings():
		settings_btn.visible = false
		settings_ui.visible = true

func _on_full_screen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		borderless.disabled = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		GameManager.save_video_setting("fullscreen", true)
		return
	borderless.disabled = true
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	GameManager.save_video_setting("fullscreen", false)

func _on_borderless_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		GameManager.save_video_setting("borderless", true)
		return
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)
	GameManager.save_video_setting("borderless", false)

func _on_back_button_pressed() -> void:
	if GameManager.request_settings_to_idle():
		settings_btn.visible = true
		settings_ui.visible = false
