class_name SimpleRocket extends Area2D


@export var max_range: float = 500.0
@export var speed: float = 300.0
@export var damage: float = 20.0


var current_range: float = 0.0:
	set(value):
		current_range = value
		if current_range > max_range:
			call_deferred("explode")


func _init() -> void:
	monitorable = false


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta
	
	current_range += speed * delta


func _on_area_entered(area: Area2D) -> void:
	if area is Mob:
		area.take_damage(damage)
		var damage_indicator: DamageIndicator = preload("res://mobs/damage_indicator.tscn").instantiate()
		get_tree().current_scene.add_child(damage_indicator)
		damage_indicator.global_position = global_position
		damage_indicator.display_amount(damage)
		queue_free()


func explode() -> void:
	queue_free()
