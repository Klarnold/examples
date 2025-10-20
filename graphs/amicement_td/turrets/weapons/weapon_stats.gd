class_name WeaponStats extends Resource


@export_range(-300.0, 300.0, 0.1) var damage: float = 20.0:
	set(new_damage):
		damage = new_damage
		emit_changed()
@export_range(-1000.0, 10000.0, 0.1) var detection_radius: float = 300.0:
	set(new_detection_radius):
		detection_radius = new_detection_radius
		emit_changed()
@export_range(-300.0, 300.0, 0.01) var fire_rate: float = 1.0:
	set(new_fire_rate):
		fire_rate = new_fire_rate
		emit_changed()
@export_range(0.0, 1000.0, 0.1) var rotation_speed: float = 3.0:
	set(new_rotation_speed):
		rotation_speed = new_rotation_speed
		emit_changed()
@export_range(0.0, 10000.0, 0.1) var bullet_speed: float = 200.0:
	set(new_bullet_speed):
		bullet_speed = new_bullet_speed
		emit_changed()
