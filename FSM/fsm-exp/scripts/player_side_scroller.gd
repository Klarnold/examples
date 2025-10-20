class_name PlayerSideScroller extends CharacterBody2D


@onready var sm: SM = %SM


var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y += gravity * delta
	
	move_and_slide()
