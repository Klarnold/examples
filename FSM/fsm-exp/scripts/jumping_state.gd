extends State


@export var player: PlayerSideScroller


func handle_input(event: InputEvent) -> void:
	pass


func enter(previous_state: String, args: Dictionary) -> void:
	player.velocity.y -= 300.0
	
	switch_state.emit("MovingState")


func exit() -> void:
	pass


func physics_update(delta: float):
	pass


func update(delta: float):
	pass
