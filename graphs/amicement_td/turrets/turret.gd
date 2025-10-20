@tool
class_name Turret extends Sprite2D


@export var packed_weapon: PackedScene = load("res://turrets/weapons/SimpleTurret.tscn"): set = set_weapon


var weapon: Weapon = null
var level: int = 1:
	set(new_level):
		level = new_level


func _ready() -> void:
	set_weapon(packed_weapon)


func set_weapon(new_packed_weapon: PackedScene) -> void:
	packed_weapon = new_packed_weapon
	var temp_stats: WeaponStats
	
	if weapon != null:
		temp_stats = weapon.stats
		weapon.queue_free()
	
	if packed_weapon != null:
		var new_weapon = packed_weapon.instantiate()
		assert(
			new_weapon is Weapon,
			"new_weapon must extend Weapon class"
		)
		if weapon != null:
			new_weapon.stats = weapon.stats
		
		weapon = new_weapon
		add_child(weapon)


func toggle_upgrades() -> void:
	if weapon != null:
		weapon.toggle_upgrades()
