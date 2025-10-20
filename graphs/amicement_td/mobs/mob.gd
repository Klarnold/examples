@icon("uid://de4svd4dltypn")
class_name Mob extends Area2D


@export var max_health: float = 100.0
@export var speed: float = 100.0
@export var coin_drop: int = 5
@export var texture: Texture = preload("res://mobs/mouse_01.png")


@onready var sprite_2d: Sprite2D = %Sprite2D
@onready var mob_shape: CollisionShape2D = %MobShape
@onready var _bar_point: Node2D = %BarPoint
@onready var _health_bar: ProgressBar = %HealthBar
@onready var health: float:
	set(value):
		health = clampf(value, 0.0, max_health) 
		if health == 0.0:
			health = 0
			_die()
		_anim_health(health)


var health_tween: Tween
var dead: bool = false


func _ready() -> void:
	add_to_group("mob")
	area_entered.connect(_on_area_entered)
	_health_bar.max_value = max_health
	health = max_health
	sprite_2d.texture = texture


func _physics_process(_delta: float) -> void:
	_bar_point.global_rotation = 0.0


func take_damage(damage: float) -> void:
	health -= damage


func _anim_health(new_health: float) -> void:
	if health_tween:
		health_tween.kill()
	
	health_tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	health_tween.tween_property(_health_bar, "value", new_health, \
									abs(new_health - _health_bar.value) * 0.02)


func _on_area_entered(area:Area2D) -> void:
	_die(false)


func _spawn_coins() -> void:
	for _i in range(coin_drop):
		var coin = Globals.coin_scene.instantiate()
		coin.global_position = global_position
		get_tree().current_scene.call_deferred("add_child", coin)


func _die(was_killed: bool = true) -> void:
	dead = true
	if was_killed:
		_spawn_coins()
	
	speed = 0.0
	
	var tween: Tween = create_tween()
	%MobShape.set_deferred("disabled", true)
	tween.tween_property(self, "modulate:a", 0.0, \
											_health_bar.value * 0.02)
	tween.finished.connect(func() -> void:
				remove_from_group("mob")
				Signals.call_deferred("emit_signal", "mob_died")
				call_deferred("queue_free")
				)
