extends Node2D

@onready var settings_btn: Button = $Control/MarginContainer/SettingsBtn
@onready var settings_ui: Control = $Control/MarginContainer/SettingsUI

func _ready() -> void:
	settings_btn.visible = true
	settings_ui.visible = false

func _on_settings_btn_pressed() -> void:
	if GameManager.request_settings():
		settings_btn.visible = false
		settings_ui.visible = true


func _on_full_screen_toggled(toggled_on: bool) -> void:
	pass # Replace with function body.


func _on_back_button_pressed() -> void:
	GameManager.request_settings_to_idle()
