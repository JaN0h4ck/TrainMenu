extends Node2D

@onready var settings_btn: Button = $Control/MarginContainer/SettingsBtn

func _on_settings_btn_pressed() -> void:
	if GameManager.request_settings():
		settings_btn.visible = false
