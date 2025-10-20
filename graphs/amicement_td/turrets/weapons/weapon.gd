@icon("uid://ble3d0fr0mb3p")
class_name Weapon extends Sprite2D


@export var stats: WeaponStats = WeaponStats.new():
	set(new_stats):
		if stats.changed.is_connected(_update_stats):
			stats.changed.disconnect(_update_stats)
		
		if new_stats != null:
			stats = new_stats
			stats.changed.connect(_update_stats)


@onready var _area_2d: Area2D = _create_area_2d()
@onready var _collision_shape_2d: CollisionShape2D = _create_collision_shape_2d()
@onready var _shoot_timer: Timer = _create_timer()

var _upgrade_anchor: Node2D
var _upgrade_wheel: UpgradeWheel


func _ready() -> void:
	if has_node("UpgradeAnchor/UpgradeWheel"):
		_upgrade_wheel = %UpgradeWheel
	
	if has_node("UpgradeAnchor"):
		_upgrade_anchor = %UpgradeAnchor
	
	call_deferred("add_child", _area_2d)
	call_deferred("add_child", _shoot_timer)
	assert(_area_2d != null, "%s _area_2d has null value" % name)
	_area_2d.call_deferred("add_child", _collision_shape_2d)
	_shoot_timer.timeout.connect(shoot)
	
	_shoot_timer.call_deferred("start")
	z_index = 10 # property for weapon to be drawen above its' bullets
	stats = stats
	_update_stats()


func _create_area_2d() -> Area2D:
	var area_2d: Area2D = Area2D.new()
	area_2d.monitorable = false
	area_2d.set_collision_mask_value(1, true)
	return area_2d


func _create_collision_shape_2d() -> CollisionShape2D:
	var collision_shape_2d: CollisionShape2D = CollisionShape2D.new()
	collision_shape_2d.shape = CircleShape2D.new()
	(collision_shape_2d.shape as CircleShape2D).radius = stats.detection_radius
	return collision_shape_2d


func _create_timer() -> Timer:
	var timer = Timer.new()
	timer.wait_time = 1.0 / stats.fire_rate
	return timer


func shoot() -> void:
	pass


func toggle_upgrades() -> void:
	if _upgrade_wheel == null:
		return
	
	_upgrade_wheel.visible = !_upgrade_wheel.visible


func _update_stats() -> void:
	_collision_shape_2d.shape.radius = stats.detection_radius
	_shoot_timer.wait_time = 1.0 / stats.fire_rate
