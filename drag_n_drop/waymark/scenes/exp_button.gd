extends Button


@onready var _texture_progress_bar: TextureProgressBar = %TextureProgressBar


func _ready() -> void:
	# TODO an example of confirm button
	#button_down.connect(_on_button_down)
	button_up.connect(_on_button_up)
	_texture_progress_bar.value_changed.connect(func(value) -> void:
												if value == _texture_progress_bar.max_value:
													queue_free())


#func _on_button_down() -> void:
	

func _on_button_up() -> void:
	_texture_progress_bar.value = 0.0


func _physics_process(delta: float) -> void:
	if button_pressed:
		_texture_progress_bar.value += 100 * delta
