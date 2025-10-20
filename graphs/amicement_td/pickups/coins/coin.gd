class_name Coin extends Area2D


@export var appear_range: float = 100.0


@onready var _coin_shape: CollisionShape2D = %CoinShape
@onready var _audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer


var _value: int = 10
var _anim_tween: Tween


func _ready() -> void:
	mouse_entered.connect(_pick_up)
	
	appear_anim()


func _pick_up() -> void:
	_coin_shape.set_deferred("disabled", true)
	_audio_stream_player.play()
	
	if _anim_tween:
		_anim_tween.kill()
		
	Globals.coins += _value
	
	_anim_tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	_anim_tween.tween_property(self, "global_position", UserUi.coins_label_pos, 0.5)
	_anim_tween.finished.connect(func() -> void:
							queue_free()
	)


func appear_anim() -> void:
	var direction: Vector2 = Vector2.from_angle(randf_range(0.0, 2.0 * PI))
	
	_anim_tween = create_tween().set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	_anim_tween.tween_property(self, "global_position", global_position + direction * randf_range(appear_range/4, appear_range), 1.0)
	
