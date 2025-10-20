class_name LevelButton extends Button


func _ready() -> void:
	pressed.connect(func() -> void:
						get_tree().change_scene_to_packed(preload("res://map/tower_defense.tscn"))
						)
