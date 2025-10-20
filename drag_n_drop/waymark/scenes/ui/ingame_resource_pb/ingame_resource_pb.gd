@tool
class_name IngameResourcePB extends ProgressBar


@export var resource_type: Globals.RESOURCE_TYPE
@export_range(0.0, 100.0, 0.1) var _max_value: float
@export_range(-100.0, 100.0, 0.1) var _value: float:
	set(new_value):
		_value = clampf(new_value, -100.0, 100.0)
		value = _value
@export var texture_over: Texture:
	set(new_texture_over):
		texture_over = new_texture_over
		var temp_style_box: StyleBoxTexture = StyleBoxTexture.new()
		temp_style_box.texture = texture_over
		add_theme_stylebox_override("fill", temp_style_box)
@export var texture_under: Texture:
	set(new_texture_under):
		texture_under = new_texture_under
		var temp_style_box: StyleBoxTexture = StyleBoxTexture.new()
		temp_style_box.texture = texture_under
		add_theme_stylebox_override("background", temp_style_box)

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	max_value = _max_value
	value = _value
	
	set_connection_with_resource()


func set_connection_with_resource():
	var _character: Character = get_tree().get_first_node_in_group("character")
	match resource_type:
		Globals.RESOURCE_TYPE.MONEY:
			_character.money_chaged.connect(func(new_value) -> void: _value = new_value)
		Globals.RESOURCE_TYPE.ENERGY:
			_character.energy_changed.connect(func(new_value) -> void: _value = new_value)
		Globals.RESOURCE_TYPE.MOOD:
			_character.mood_changed.connect(func(new_value) -> void: _value = new_value)
