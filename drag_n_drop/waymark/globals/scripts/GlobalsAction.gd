extends Node


const ACTION_SCENE: PackedScene = preload("res://scenes/elements/action/action.tscn")


enum ACTION_TYPE{
	WORK,
	REST,
	SHOPPING
}


const ACTION_NAME: String = "Action"
