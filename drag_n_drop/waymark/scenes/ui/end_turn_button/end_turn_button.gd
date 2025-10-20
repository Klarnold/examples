class_name EndTurnButton extends Button


@export var pre_end_turn_scene: PackedScene = preload("res://scenes/ui/pre_end_turn_panel/pre_end_turn_panel.tscn") 


func _ready() -> void:
	pressed.connect(_on_end_turn_button_pressed)


func _on_end_turn_button_pressed() -> void:
	GlobalUi.add_child(pre_end_turn_scene.instantiate())
