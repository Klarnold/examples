class_name FinishTurnButton extends Button


func _ready() -> void:
	pressed.connect(Signals.finish_turn_button_pressed.emit)
