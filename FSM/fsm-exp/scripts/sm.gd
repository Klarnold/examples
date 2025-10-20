class_name SM extends Node


@export var initial_state_path: String
@export var initial_state_args: Dictionary

var current_state: State


func _ready() -> void:
	for state: State in get_children():
		state.switch_state.connect(switch_state)
	
	if get_node(initial_state_path):
		current_state = get_node(initial_state_path)
		current_state.enter(initial_state_path, initial_state_args)


func _unhandled_input(event: InputEvent) -> void:
	current_state.handle_input(event)


func switch_state(new_state_path: String, args: Dictionary = {}) -> void:
	if not has_node(new_state_path):
		printerr("SM get NO existing state while changing")
	
	current_state.exit()
	current_state = get_node(new_state_path)
	current_state.enter(new_state_path, args)


func _physics_process(delta: float) -> void:
	current_state.physics_update(delta)


func _process(delta: float) -> void:
	current_state.update(delta)
