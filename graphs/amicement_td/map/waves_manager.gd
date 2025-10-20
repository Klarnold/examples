@tool
extends Node2D
class_name WavesManager


@export var waves: Array[MobWaveRes] = []:
	set = set_waves


@onready var current_wave_idx: int = 0


func _ready() -> void:
	call_deferred("start_wave")


func start_wave() -> void:
	if current_wave_idx > (get_children().size() - 1):
		Globals.allowed_to_win = true
		return
	
	var mob_spawner: MobSpawner = preload("res://map/mob_spawner.tscn").instantiate()
	var current_wave: Wave = get_child(current_wave_idx)
	mob_spawner._path_2d = current_wave.path_2d
	mob_spawner.mob_amount = waves[current_wave_idx].mob_amount
	mob_spawner.spawn_interval = waves[current_wave_idx].spawn_delay
	
	current_wave.add_child(mob_spawner)
	mob_spawner.mob_packed = waves[current_wave_idx].mob_packed
	
	current_wave.start_next_wave.connect(start_wave)
	current_wave.wave_delay_timer.wait_time = waves[current_wave_idx].next_wave_delay
	current_wave.call_deferred("create_new_wave_starter")
	
	current_wave_idx += 1


func _get_configuration_warnings() -> PackedStringArray:
	if waves.size() == 0:
		return["You need to define MobWavesRes at 'waves' variable"]
	return[]


#func set_paths(paths: PackedVector2Array) -> void: # TODO set_path in tower_defense.gd
	#for wave: Wave in get_children():
		#for point in paths:
			#wave.path_2d.curve.add_point(point)


func set_waves(new_waves: Array[MobWaveRes]) -> void:
	for wave_idx in new_waves.size():
		if new_waves[wave_idx] == null:
			new_waves[wave_idx] = MobWaveRes.new()
	
	waves = new_waves
	update_configuration_warnings()
