class_name SettingsMain extends Control


signal show_main_menu


@onready var _music_slider: HSlider = %MusicSlider
@onready var _sounds_slider: HSlider = %SoundsSlider
@onready var _return: Button = %Return


func _ready() -> void:
	_return.pressed.connect(show_main_menu.emit)
	
	_music_slider.value_changed.connect(_audio_bus_changed.bind(1))
	_sounds_slider.value_changed.connect(_audio_bus_changed.bind(2))


func _audio_bus_changed(value:float, bus_id: int) -> void:
	AudioServer.set_bus_volume_db(bus_id, linear_to_db(value))
