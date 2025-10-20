extends Area2D


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _physics_process(delta: float) -> void:
	global_position = get_global_mouse_position()


func _on_area_entered(area: Area2D) -> void:
	if area is Coin:
		area._pick_up()
