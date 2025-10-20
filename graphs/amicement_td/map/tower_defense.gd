class_name Level extends Node2D


@onready var _increase: Button = %Increase
@onready var _decrease: Button = %Decrease
@onready var _hit_box: Area2D = %HitBox
@onready var _grass: TileMapLayer = %Grass
@onready var _road: Road = %Road
@onready var _waves_manager: WavesManager = %WavesManager
@onready var UPGRADE: TurretUpgrade = preload("res://turrets/upgrades/ALL_UPGRADE.tres")
@onready var _turret_wheel_scene : PackedScene = preload("res://turrets/upgrades/turret_wheel.tscn")


var map_dict: Dictionary[Vector2i, Turret]
var turret_cost: int = 40
var _current_turret_wheel: UpgradeWheel


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_released("click"):
		_check_map_grid(get_global_mouse_position())

func _ready() -> void:
	GlobalAudio.transition_to(load("res://assets/audio/freepik-cold-steel-tears.mp3"))
	
	Signals.mob_died.connect(_check_win)
	Signals.place_turret.connect(place_turret)
	
	_hit_box.area_entered.connect(_damage_player)
	_increase.pressed.connect(func() -> void: Globals.health += 1)
	_decrease.pressed.connect(func() -> void: Globals.health -= 1)
	
	Globals.coins = 100
	
	for wave: Wave in _waves_manager.get_children():
		wave.set_path(_road.find_path_to_point(wave.global_position, _hit_box.global_position))


func _check_map_grid(global_mouse_pos: Vector2):
	if _current_turret_wheel:
		_current_turret_wheel.queue_free()
	
	if (
		_road.get_cell_source_id(_road.local_to_map(global_mouse_pos)) != -1
	):
		return
	elif map_dict.has(_grass.local_to_map(global_mouse_pos)) and map_dict[_grass.local_to_map(global_mouse_pos)] != null:
		map_dict[_grass.local_to_map(global_mouse_pos)].toggle_upgrades()
		#if Globals.coins >= UPGRADE.cost:
			#_spawn_stars(_grass.map_to_local(_grass.local_to_map(global_mouse_pos)))
			#Globals.coins -= UPGRADE.cost
			#UPGRADE.apply_to_turrer(map_dict[_grass.local_to_map(global_mouse_pos)])
		return
	
	_place_turret_wheel(_grass.map_to_local(_grass.local_to_map(global_mouse_pos)))
	#place_turret(_grass.local_to_map(global_mouse_pos))


func _damage_player(area: Area2D) -> void:
	if area is Mob:
		Globals.health -= 1


func _check_win() -> void:
	if Globals.allowed_to_win and get_tree().get_node_count_in_group("mob") == 0:
		await get_tree().create_timer(11.0)
		if get_tree().get_node_count_in_group("mob") == 0:
			Signals.player_won.emit()


func place_turret(pos: Vector2, packed_weapon: PackedScene) -> void:
	
	#Globals.coins -= turret_cost
	
	var new_turret: Turret = load("res://turrets/turret.tscn").instantiate()
	map_dict[_grass.local_to_map(pos)] = new_turret
	new_turret.position = _grass.map_to_local(_grass.local_to_map(pos))
	new_turret.packed_weapon = packed_weapon
	_spawn_stars(new_turret.position)
	add_child(new_turret)


func _place_turret_wheel(wheel_pos: Vector2) -> void:
	if _current_turret_wheel:
		_current_turret_wheel.queue_free()
	
	_current_turret_wheel = _turret_wheel_scene.instantiate()
	_current_turret_wheel.position = wheel_pos
	_current_turret_wheel.visible = true
	
	add_child(_current_turret_wheel)


func _spawn_stars(pos: Vector2) -> void:
	var stars_particles: GPUParticles2D = preload("res://map/gpu_stars_particles.tscn").instantiate()
	
	stars_particles.global_position = pos
	add_child(stars_particles)
	
	stars_particles.finished.connect(stars_particles.queue_free)
	stars_particles.restart()
