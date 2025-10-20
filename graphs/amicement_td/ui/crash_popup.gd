class_name CrashPopup extends Control


@onready var _time_left: Label = $CrashPopup/MarginContainer/VBoxContainer/TimeLeft


var time_left_float: float = 5.00:
	set(new_time):
		time_left_float = new_time
		_time_left.text = str(snappedf(time_left_float, 0.01))


func _ready() -> void:
	call_deferred("_crash_game")


func _crash_game() -> void:
	var tween: Tween = get_tree().create_tween()
	tween.tween_property(self, "time_left_float", 0.0, 5.0)
	tween.finished.connect(get_tree().quit)

#func _change_time_left_float(delta):
	#time_left_float = 5.0 - 5.0 * d
