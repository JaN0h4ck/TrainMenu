extends Node2D

@onready var settings_btn: Button = $Control/MarginContainer/SettingsBtn
@onready var settings_ui: Control = $Control/MarginContainer/SettingsUI
@onready var borderless: CheckBox = $Control/MarginContainer/SettingsUI/HBoxContainer/Left/Borderless

func _ready() -> void:
	settings_btn.visible = true
	settings_ui.visible = false
	borderless.disabled = true

func _on_settings_btn_pressed() -> void:
	if GameManager.request_settings():
		settings_btn.visible = false
		settings_ui.visible = true


func _on_full_screen_toggled(toggled_on: bool) -> void:
	if toggled_on:
		borderless.disabled = false
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		return
	borderless.disabled = true
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_borderless_toggled(toggled_on: bool) -> void:
	if toggled_on:
		DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, true)
		return
	DisplayServer.window_set_flag(DisplayServer.WINDOW_FLAG_BORDERLESS, false)

func _on_back_button_pressed() -> void:
	GameManager.request_settings_to_idle()
