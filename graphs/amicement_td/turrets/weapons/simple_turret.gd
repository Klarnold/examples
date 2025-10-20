class_name SimpleTurret extends Weapon


@onready var _shoot_marker: Marker2D = %ShootMarker
@onready var _audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer


func _ready() -> void:
	super()
	
	for upgrade_round: UpgradeRound in _upgrade_wheel.get_children().slice(1):
		if get_parent() is Turret:
			upgrade_round._turret = get_parent()


func _physics_process(delta: float) -> void:
	var mobs_in_area: Array = _area_2d.get_overlapping_areas()
	if not mobs_in_area.is_empty():
		#look_at(mobs_in_area.front().global_position)
		rotation = rotate_toward(rotation, Vector2.RIGHT.angle_to(mobs_in_area.front().global_position - global_position) , stats.rotation_speed * delta)
		#look_at(mobs_in_area.front().global_position)
	if _upgrade_anchor:
		_upgrade_anchor.global_rotation = 0.0


func shoot() -> void:
	if _area_2d.get_overlapping_areas().is_empty():
		return
	
	var bullet = preload("res://turrets/weapons/projectiles/simple_rocket.tscn").instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.damage = stats.damage
	bullet.global_transform = _shoot_marker.global_transform
	bullet.rotation = rotation
	bullet.speed = stats.bullet_speed
	bullet.max_range = stats.detection_radius
	
	_audio_stream_player.play()
