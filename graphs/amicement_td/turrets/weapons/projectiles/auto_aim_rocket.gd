class_name HomingRocket extends Area2D


#const INF = 100


@export var max_range: float = 500.0
@export var speed: float = 300.0
@export var damage: float = 20.0


@onready var _search_area: Area2D = %SearchArea
@onready var _animated_sprite_2d: AnimatedSprite2D = %AnimatedSprite2D
@onready var _rocket_flame: Sprite2D = %RocketFlame


@export var target: Mob:
	set(new_mob):
		if new_mob == null:
			target = find_closest_mob()
		else:
			target = new_mob
var current_range: float = 0.0:
	set(value):
		current_range = value
		if current_range > max_range:
			call_deferred("explode")


func _init() -> void:
	monitorable = false


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	_search_area.monitorable = false
	
	target = target

func _physics_process(delta: float) -> void:
	position += transform.x * speed * delta
	
	if target and not target.dead:
		var accel = target.global_position - global_position
		
		if not _search_area.get_overlapping_areas().is_empty():
			rotation = rotate_toward(rotation,  global_position.angle_to(target.global_position - global_position), delta * PI * 600 / (target.global_position - global_position).length())
	else:
		target = find_closest_mob()
	
	current_range += speed * delta


func _on_area_entered(area: Area2D) -> void:
	if area is Mob:
		explode()


func explode() -> void:
	if not is_physics_processing():
		return
	set_physics_process(false)
	_animated_sprite_2d.play("explosion")
	_rocket_flame.visible = false
	
	var explosion = load("res://turrets/weapons/explosion/explosion.tscn").instantiate()
	explosion.damage = damage
	explosion.set_deferred("position", global_position)
	get_tree().current_scene.call_deferred("add_child", explosion)
	
	_animated_sprite_2d.animation_finished.connect(queue_free)


func find_closest_mob() -> Mob:
	var temp_mob: Mob
	var closest: float = INF
	
	for mob: Mob in get_tree().get_nodes_in_group("mob"):
		if global_position.distance_to(mob.global_position) < closest:
			temp_mob = mob
			closest = global_position.distance_to(mob.global_position)
	
	return temp_mob
