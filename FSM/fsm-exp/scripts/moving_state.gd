extends State

@export_range(0.0, 1000.0, 1.0) var speed: float = 500.0
@export_range(0.0, 1000.0, 1.0) var acceleration: float = 2.0
@export var player: PlayerSideScroller


func handle_input(event: InputEvent) -> void:
	if event.is_action_pressed("jump"):
		switch_state.emit("JumpingState")


func enter(previous_state: String, args: Dictionary) -> void:
	pass


func exit() -> void:
	pass


func physics_update(delta: float):
	var direction = signf(Input.get_axis("moving_left", "moving_right"))
	
	var desired_velocity: Vector2 = speed * direction * Vector2.RIGHT
	player.velocity = lerp(player.velocity, desired_velocity - player.velocity, acceleration * delta)


func update(delta: float):
	pass
