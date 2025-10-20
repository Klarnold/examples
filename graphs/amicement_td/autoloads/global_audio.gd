extends AudioStreamPlayer


var transition_tween: Tween


func transition_to(new_stream: AudioStream) -> void:
	if new_stream == stream:
		return
	
	if transition_tween:
		transition_tween.kill()
	
	var current_db: float = volume_db
	
	transition_tween = create_tween()
	transition_tween.tween_property(self, "volume_db", -20.0, 2.0)
	transition_tween.finished.connect(func() -> void:
										stream = new_stream
										transition_tween = create_tween()
										play()
										transition_tween.tween_property(self, "volume_db", current_db, 2.0))
	
