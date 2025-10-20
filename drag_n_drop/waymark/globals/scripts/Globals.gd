extends Node


enum RESOURCE_TYPE{
	NONE,
	MONEY,
	ENERGY,
	MOOD
}


var action_instance: Action:
	set = set_action_instance


func set_action_instance(new_action_instance: Action):
	action_instance = new_action_instance
