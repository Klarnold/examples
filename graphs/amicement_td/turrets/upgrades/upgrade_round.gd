@tool
class_name UpgradeRound extends PanelContainer


@export var texture: Texture:
	set(new_texture):
		texture = new_texture
		if Engine.is_editor_hint():
			_texture_rect.texture = texture
@export var _upgrade_res: TurretUpgrade:
	set(new_upgrade_res):
		_upgrade_res = new_upgrade_res
		if Engine.is_editor_hint():
			_cost.text = str(_upgrade_res.cost)
@export var upgrades_cap: int = 3
@export_color_no_alpha var purchased_color
@export_multiline var description_text: String

@onready var _texture_rect: TextureRect = %TextureRect
@onready var _upgrade_count_container: VBoxContainer = %UpgradeCountContainer
@onready var _description: Description = %Description
@onready var _cost: Label = %Cost

var _turret: Turret

func _ready() -> void:
	if Engine.is_editor_hint():
		return
	
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
	_texture_rect.texture = texture
	_description.set_text(description_text)
	_cost.text = str(_upgrade_res.cost)
	
	assert(_upgrade_res != null, "%s(UpgradeRound) had no _upgrade_res" % name)
	for _i in range(upgrades_cap):
		_upgrade_count_container.add_child(load("res://turrets/upgrades/upgrade_count.tscn").instantiate())


func _gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("click"):
		if Globals.coins >= _upgrade_res.cost:
			if (_upgrade_count_container.get_child(upgrades_cap-1) as Panel).modulate == purchased_color:
				return
			
			for upgrade_count in _upgrade_count_container.get_children():
				if upgrade_count.modulate != purchased_color:
					upgrade_count.modulate = purchased_color
					if upgrade_count == _upgrade_count_container.get_children()[-1]:
						_cost.text = "MAX"
					break
			
			Globals.coins += _upgrade_res.cost 
			
			if _turret == null:
				Signals.place_turret.emit(get_parent().global_position + get_parent().size/2.0, _upgrade_res.new_weapon_scene)
				get_parent().call_deferred("queue_free")
			else:
				_upgrade_res.apply_to_turrer(_turret)
		#get_viewport().set_input_as_handled()


func _on_mouse_entered() -> void:
	_description.show_itself()


func _on_mouse_exited() -> void:
	_description.hide_itself()
