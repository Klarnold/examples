class_name TurretUpgrade extends Resource


@export_range(0.0, 1000.0, 0.1) var cost: float
@export_range(-100.0, 100.0, 0.1) var damage: float
@export_range(-300.0, 300.0, 0.1) var detection_radius: float
@export_range(-300.0, 300.0, 0.01) var fire_rate: float
@export_range(-10000.0, 10000.0, 0.1) var bullet_speed: float
@export_range(-2.0 * PI, 2.0 * PI, 0.1) var rotation_speed: float
@export var new_weapon_scene: PackedScene


func apply_to_turrer(turret: Turret) -> void:
	turret.level += 1
	turret.weapon.stats.damage += damage
	turret.weapon.stats.detection_radius += detection_radius
	turret.weapon.stats.fire_rate += fire_rate
	turret.weapon.stats.bullet_speed += bullet_speed
	turret.weapon.stats.rotation_speed += rotation_speed
	
	if new_weapon_scene != null:
		turret.set_weapon(new_weapon_scene)
