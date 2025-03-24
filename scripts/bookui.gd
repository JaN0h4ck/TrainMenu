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
