class_name NextWave extends Control


signal next_wave_pressed


@export var wait_time: float


@onready var _texture_progress_bar: TextureProgressBar = %TextureProgressBar


var tween: Tween


func _ready() -> void:
	tween = create_tween()
	
	tween.tween_property(_texture_progress_bar, "value", _texture_progress_bar.max_value, wait_time)
	
	tween.finished.connect(_on_next_wave_pressed)


func _gui_input(event: InputEvent) -> void:
	if event.is_action_released("click"):
		if tween:
			tween.kill()
		
		_on_next_wave_pressed()


func _on_next_wave_pressed() -> void:
	next_wave_pressed.emit()
	call_deferred("queue_free")
