@abstract
class_name State extends Node

@warning_ignore("unused_signal")
signal switch_state(new_state_path: String, args: Dictionary)


func _ready() -> void:
	set_physics_process(false)


@abstract
func handle_input(event: InputEvent) -> void


@abstract
func enter(previous_state: String, args: Dictionary) -> void

@abstract
func exit() -> void

@abstract
func physics_update(delta: float)

@abstract
func update(delta: float)
