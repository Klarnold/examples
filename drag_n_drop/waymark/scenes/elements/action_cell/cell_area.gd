extends Area2D


func _input_event(viewport: Viewport, event: InputEvent, shape_idx: int) -> void:
	print(event.as_text())
