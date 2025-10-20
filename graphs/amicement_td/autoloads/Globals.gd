extends Node


var coin_scene: PackedScene = preload("res://pickups/coins/coin.tscn")


var health = 5:
	set(value):
		health = value
		Signals.player_health_changed.emit()
		
var allowed_to_win: bool = false
var coins: int = 100:
	set(value):
		coins = value
		UserUi.coins_changed.emit(coins)
