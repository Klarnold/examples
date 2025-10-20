class_name Exp extends Node2D


@onready var _energy_label: Label = %EnergyLabel
@onready var _energy_pb: IngameResourcePB = %EnergyPB


func _ready() -> void:
	_energy_pb.value_changed.connect(func(value: float) -> void:
										_energy_label.text = str(snappedf(value, 0.1))
										)
