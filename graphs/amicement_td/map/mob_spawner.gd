@tool
class_name MobSpawner extends Node2D


@export_range(1, 100, 1) var mob_amount: int
@export_range(0.1, 10.0, 0.05) var spawn_interval: float
@export var _path_2d: Path2D:
	set(value):
		_path_2d = value
		update_configuration_warnings()


@onready var mob_path_packed: PackedScene = preload("res://mobs/mob_path_follow.tscn")
@onready var mob_packed: PackedScene = preload("uid://bf8paumt0pffp")
@onready var _spawn_cooldown_timer: Timer = %SpawnCooldownTimer


var _remaining_mobs: int


func _ready() -> void:
	if Engine.is_editor_hint():
		return
	_remaining_mobs = mob_amount
	
	_spawn_cooldown_timer.timeout.connect(spawn_mob)
	_spawn_cooldown_timer.one_shot = true
	_spawn_cooldown_timer.wait_time = spawn_interval
	
	assert(_path_2d != null, "%s _path_2d is null" % name)


func spawn_wave() -> void:
	#for _i in mob_amount:
		#_spawn_cooldown_timer.start()
		#await _spawn_cooldown_timer.timeout
	_remaining_mobs -= 1
	_spawn_cooldown_timer.start()
	await _spawn_cooldown_timer.timeout
	if _remaining_mobs > 0:
		spawn_wave()


func spawn_mob() -> void:
	var mob_path_follow: MobPathFollow = mob_path_packed.instantiate()
	var mob = mob_packed.instantiate()
	mob_path_follow.mob = mob
	_path_2d.add_child(mob_path_follow)
	mob_path_follow.add_child(mob)


func _get_configuration_warnings() -> PackedStringArray:
	if _path_2d == null:
		return ["_path_2d needs to be setted. If you have no Path2D, instantiate one"]
	return []
