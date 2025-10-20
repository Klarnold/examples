extends CanvasLayer


func create_reources_panel() -> void:
	add_child(load("res://scenes/ui/resources_panel/resources_panel.tscn").instantiate())
