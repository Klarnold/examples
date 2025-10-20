extends Control


signal coins_changed


@onready var _health_container: HBoxContainer = %HealthContainer
@onready var _coins_label: Label = %CoinsLabel
@onready var _coins_label_texture: TextureRect = %CoinsLabelTexture


static var coins_label_pos: Vector2


func _ready() -> void:
	Signals.player_health_changed.connect(_on_player_health_changed)
	coins_changed.connect(set_coins)
	
	Globals.health = Globals.health
	coins_label_pos = %CoinsMarker.global_position


func _on_player_health_changed() -> void:
	var health_count: int = _health_container.get_child_count()
	if Globals.health > health_count:
		for _i in (Globals.health - health_count):
			var health_point: TextureRect = TextureRect.new()
			health_point.texture = load("res://ui/heart.png")
			health_point.mouse_filter = Control.MOUSE_FILTER_IGNORE
			_health_container.add_child(health_point)
	else:
		var health_points = _health_container.get_children()
		for _i in (health_count - Globals.health):
			_health_container.remove_child(health_points.pop_front())


func set_coins(value) -> void:
	_coins_label.text = "%s " % str(value)
