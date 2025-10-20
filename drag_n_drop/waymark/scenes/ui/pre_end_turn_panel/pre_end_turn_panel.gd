class_name PreEndTurnPanel extends Control


@onready var _end_turn: Button = %EndTurn
@onready var _back: Button = %Back
@onready var _money_label: RichTextLabel = %MoneyLabel
@onready var _energy_label: RichTextLabel = %EnergyLabel
@onready var _mood_label: RichTextLabel = %MoodLabel
@onready var _end_turn_progress: TextureProgressBar = %EndTurnProgress


var _total_money: float = 0.0
var _total_energy: float = 0.0
var _total_mood: float = 0.0


func _ready() -> void:
	_back.pressed.connect(queue_free)
	
	_get_total_all()
	
	_set_all()


func _get_total_all() -> void:
	var _character: Character = get_tree().get_first_node_in_group("character")
	_total_money = _character.get_money()
	_total_energy = _character.get_energy()
	_total_mood = _character.get_mood()
	for action: Action in get_tree().get_nodes_in_group("action"):
		_total_money += action.action_res.money
		_total_energy += action.action_res.energy
		_total_mood += action.action_res.mood


func _set_all() -> void:
	var _character: Character = get_tree().get_first_node_in_group("character")
	_money_label.text = "%s -> %s" % [_character.get_money(), _total_money]
	_energy_label.text = "%s -> %s" % [_character.get_energy(), _total_energy]
	_mood_label.text = "%s -> %s" % [_character.get_mood(), _total_mood]


func _physics_process(delta: float) -> void:
	if _end_turn.button_pressed:
		_end_turn_progress.visible = true
		_end_turn_progress.value += delta * 100
		if _end_turn_progress.value == _end_turn_progress.max_value:
			_prepare_and_end_turn()
			set_physics_process(false)
	else:
		_end_turn_progress.visible = false
		_end_turn_progress.value = 0.0


func _prepare_and_end_turn() -> void:
	Signals.start_new_turn.emit(_get_end_turn_resource())
	queue_free()


func _get_end_turn_resource() -> Dictionary:
	var end_turn_resources: Dictionary = {}
	
	if _money_label:
		end_turn_resources["money"] = _total_money
	
	if _energy_label:
		end_turn_resources["energy"] = _total_energy
	
	if _mood_label:
		end_turn_resources["mood"] = _total_mood
	
	return end_turn_resources
