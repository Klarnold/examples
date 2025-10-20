@tool
class_name ActionSpawner extends TextureRect


@export_range(0.0, 1000.0, 1.0) var max_chain_length: float
@export var action_res: ActionRes
@export var main_texture: Texture:
	set(new_texture):
		main_texture = new_texture
		texture = main_texture

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	assert(action_res != null, "%s spawner has no action_res" % name)
	
	focus_entered.connect(func() -> void: print("%s focus entered +" % name))
	focus_exited.connect(func() -> void: print("%s focus exited -" % name))

func _gui_input(event: InputEvent) -> void:
	if Engine.is_editor_hint():
		return
	
	if event.is_action_pressed("click"):
		var new_action_instance: Action =  GlobalsAction.ACTION_SCENE.instantiate()
		if Globals.action_instance == new_action_instance:
			Globals.action_instance.queue_free()
			return
		new_action_instance.action_res = action_res
		
		Globals.action_instance = new_action_instance


#func _physics_process(delta: float) -> void:
	#var current_mouse_global_pos: Vector2 = get_global_mouse_position()
	#if (drag_st_pos - current_mouse_global_pos).length() > max_chain_length:
		#dragged = false
		#var new_action: Action = action_scene.instantiate()
		#get_tree().current_scene.call_deferred("add_child", new_action)
		#new_action.global_position = get_global_mouse_position() + new_action.size/2.0
