class_name LevelsMenu extends Control


signal close_levels_menu


@onready var _return: Button = %Return
@onready var _levels_grid_container: GridContainer = %LevelsGridContainer


func _ready() -> void:
	_return.pressed.connect(close_levels_menu.emit)
	
	for level_btn: Button in _levels_grid_container.get_children():
		level_btn.pressed.connect(set_deferred.bind("visible", false))
	
