class_name MainMenu extends Control


signal show_settings_main
signal show_levels_menu
signal show_credits


@onready var _parallax_layer: ParallaxLayer = %ParallaxLayer
@onready var _sprite_2d: Sprite2D = %Sprite2D
@onready var _play: Button = %Play
@onready var _settings: Button = %Settings
@onready var _credits: Button = %Credits
@onready var _exit: Button = %Exit
@onready var parallax_background: ParallaxBackground = %ParallaxBackground


func _ready() -> void:
	GlobalAudio.transition_to(load("res://assets/audio/freepik-cold-steel-tears.mp3"))
	
	_play.pressed.connect(_on_play_button_pressed)
	_settings.pressed.connect(_on_settings_button_pressed)
	_credits.pressed.connect(_on_credits_button_pressed)
	_exit.pressed.connect(get_tree().quit)
	Signals.call_deferred("emit_signal", "main_menu_is_ready", self)


func _physics_process(delta: float) -> void:
	_parallax_layer.motion_offset.x -= 420 * delta


func _on_play_button_pressed() -> void:
	show_levels_menu.emit()


func _on_settings_button_pressed() -> void:
	show_settings_main.emit()


func _on_credits_button_pressed() -> void:
	show_credits.emit()
