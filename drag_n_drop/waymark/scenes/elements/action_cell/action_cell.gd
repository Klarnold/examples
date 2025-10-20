class_name ActionCell extends TextureRect


@onready var _cell_area: Area2D = %CellArea
@onready var _cell_area_shape: CollisionShape2D = %CellAreaShape
#@onready var _cell: TextureRect = %Cell


func _gui_input(event: InputEvent) -> void:
	#print(event)
	if event.is_action_pressed("click") and Globals.action_instance != null:
		prepare_to_add_action(Globals.action_instance)


func _ready() -> void:
	_cell_area.area_entered.connect(_on_cell_area_entered)
	
	size_flags_vertical = 4
	size_flags_horizontal = 4
	await get_tree().physics_frame
	await get_tree().physics_frame 
	_cell_area.global_position = global_position + size * 0.5
	_cell_area_shape.shape.size = size


func _on_cell_area_entered(action_area: Area2D) -> void:
	action_area


func prepare_to_add_action(new_action: Action) -> void:
	if has_node(GlobalsAction.ACTION_NAME) and get_node(GlobalsAction.ACTION_NAME) != new_action:
			var current_action: Action = get_node(GlobalsAction.ACTION_NAME)
			
			if new_action.get_parent() is ActionCell:
				var new_action_cell_parent: ActionCell = new_action.get_parent()
				remove_child(current_action)
				new_action_cell_parent.remove_child(new_action)
				new_action_cell_parent.add_action(current_action)
				
				add_action(new_action)
	else:
		add_action(new_action)


func add_action(new_action: Action) -> void:
	new_action._chained_pos = self.size / 2.0 + self.global_position - new_action.size / 2.0
	var new_action_parent = new_action.get_parent()
	if new_action_parent != null:
		new_action.call_deferred("reparent", self)
	else:
		call_deferred("add_child", new_action)
	new_action.set_deferred("global_position", new_action._chained_pos)
	new_action.set_deferred("name", GlobalsAction.ACTION_NAME)
	#if new_action == Globals.action_instance:
		#Globals.set_deferred("action_instance", new_action)
	Globals.action_instance = null
	#mouse_filter = Control.MOUSE_FILTER_IGNORE
