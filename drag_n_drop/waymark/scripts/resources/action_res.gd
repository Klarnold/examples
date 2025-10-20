class_name ActionRes extends Resource


@export var action_type: GlobalsAction.ACTION_TYPE
@export_range(-10_000.0, 10_000, 0.1) var money: float
@export_range(-100.0, 100.0, 0.01) var energy: float
@export_range(-100.0, 100.0, 0.01) var mood: float
@export var texture: Texture
