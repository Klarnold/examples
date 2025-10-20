extends Node2D


func _physics_process(_delta: float) -> void:
	if has_node("Mob"):
		$Mob.position = get_global_mouse_position()
