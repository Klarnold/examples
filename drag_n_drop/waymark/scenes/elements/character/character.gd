class_name Character extends Control


@export var character_res: CharacterRes


signal money_chaged(value: float)
signal energy_changed(value: float)
signal mood_changed(value: float) 


func _ready() -> void:
	#assert(character_res != null, "%s character has no character res" % name) TODO
	
	pass


func get_money() -> float:
	return character_res.money


func get_energy() -> float:
	return character_res.energy


func get_mood() -> float:
	return character_res.energy


func set_money(new_money: float) -> void:
	character_res.money = new_money
	money_chaged.emit(new_money)


func set_energy(new_energy: float) -> void:
	character_res.energy = new_energy
	energy_changed.emit(new_energy)


func set_mood(new_mood: float) -> void:
	character_res.mood = new_mood
	mood_changed.emit(new_mood)
