@tool
class_name Wave extends Node2D


signal start_next_wave


@export var next_wave_grid_offset: Vector2i


var path_2d: Path2D = Path2D.new()

@onready var wave_delay_timer: Timer = %WaveDelayTimer


var mob_spawner: MobSpawner


func _ready() -> void:
	path_2d.curve = Curve2D.new()
	path_2d.top_level = true
	add_child(path_2d)


func start_wave() -> void:
	var spawners = get_children()
	if get_children().size() > 0:
		start_next_wave.emit()
		for child in spawners:
			if child is MobSpawner:
				child.spawn_wave()


func create_new_wave_starter() -> void:
	var new_wave_starter: NextWave = load("res://map/next_wave.tscn").instantiate()
	
	new_wave_starter.position = next_wave_grid_offset * 64 # NOTE 64 - размерность игровой сетки в пикселях
	new_wave_starter.wait_time = wave_delay_timer.wait_time
	new_wave_starter.next_wave_pressed.connect(start_wave)
	
	add_child(new_wave_starter)


func set_path(path: PackedVector2Array):
	path_2d.curve.clear_points()
	for point in path:
		path_2d.curve.add_point(point)


func _get_configuration_warnings() -> PackedStringArray:
	if path_2d == null:
		return ["path_2d needs to be setted. If you have no Path2D, instantiate one"]
	return []
