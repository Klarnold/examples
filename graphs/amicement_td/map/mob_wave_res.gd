class_name MobWaveRes extends Resource


@export_range(1, 100, 1) var mob_amount: int
@export_range(0.1, 5.0, 0.05) var spawn_delay: float
@export var mob_packed: PackedScene
@export_range(1.0, 60.0, 0.1) var next_wave_delay: float = 1.0
