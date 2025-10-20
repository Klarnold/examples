class_name PauseMenu extends Control


signal show_pause_menu_settings


@onready var _pause_button: Button = %PauseButton
@onready var _settings: Button = %Settings
@onready var _resume: Button = %Resume
@onready var _quit: Button = %Quit


func _ready() -> void:
	_pause_button.pressed.connect(_on_pause_button_pressed)
	_settings.pressed.connect(_on_setting_button_pressed)
	_quit.pressed.connect(_on_quit_button_pressed)


func _on_pause_button_pressed() -> void:
	var new_screen = Popup.new()
	new_screen.visible = true
	get_tree().current_scene.add_child(new_screen)


func _on_setting_button_pressed() -> void:
	show_pause_menu_settings.emit()
	visible = false


func _on_quit_button_pressed() -> void:
	visible = false
	get_tree().change_scene_to_packed(load("res://ui/main_menu.tscn"))
