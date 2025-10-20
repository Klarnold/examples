extends CanvasLayer


signal crash_game


@onready var _restart_button: Button = %RestartButton
@onready var _quit_button: Button = %QuitButton
@onready var _game_over_menu: Control = %GameOverMenu
@onready var _win_menu: Control = %WinMenu
@onready var _win_restart_button: Button = %WinRestartButton
@onready var _win_quit_button: Button = %WinQuitButton
@onready var _pause_menu: PauseMenu = %PauseMenu
@onready var _main_menu: MainMenu:
	set(new_main_menu):
		_main_menu = new_main_menu
		if _main_menu != null:
			if not _main_menu.show_settings_main.is_connected(_show_settings_main):
				_main_menu.show_settings_main.connect(_show_settings_main)
			if not _main_menu.show_levels_menu.is_connected(_show_levels_menu):
				_main_menu.show_levels_menu.connect(_show_levels_menu)
			if not _main_menu.show_credits.is_connected(_show_credits):
				_main_menu.show_credits.connect(_show_credits)
@onready var _settings_main: SettingsMain = %SettingsMain
@onready var _levels_menu: LevelsMenu = %LevelsMenu


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape") and get_tree().current_scene is Level:
		_show_pause_menu()


func _ready() -> void:
	Signals.player_lost.connect(_show_game_over_menu)
	Signals.player_won.connect(_show_win_menu)
	Signals.show_pause_menu.connect(_on_show_pause_menu)
	Signals.main_menu_is_ready.connect(reset_main_menu)
	
	_main_menu = %MainMenu
	#_main_menu.show_settings_main.connect(_show_settings_main)
	#_main_menu.show_levels_menu.connect(_show_levels_menu)
	#_main_menu.show_credits.connect(_show_credits)
	_settings_main.show_main_menu.connect(_show_main_menu)
	_levels_menu.close_levels_menu.connect(_close_levels_menu)
	_pause_menu.show_pause_menu_settings.connect(_show_settings_main)
	
	crash_game.connect(_on_crash_game)
	
	_win_restart_button.pressed.connect(func() -> void:
									_win_menu.visible = false
									_restart_game()
									)
	_restart_button.pressed.connect(func() -> void:
									_game_over_menu.visible = false
									_restart_game()
									)
	_win_quit_button.pressed.connect(get_tree().quit)
	_quit_button.pressed.connect(get_tree().quit)


func _show_game_over_menu() -> void:
	GlobalAudio.transition_to(load("res://assets/audio/losemusic.mp3"))
	get_tree().paused = true
	_game_over_menu.visible = true


func _show_win_menu() -> void:
	GlobalAudio.transition_to(load("res://assets/audio/win.mp3"))
	get_tree().paused = true
	_win_menu.visible = true


func _on_show_pause_menu() -> void:
	_pause_menu.visible = true


func _restart_game() -> void:
	get_tree().paused = false
	Globals.health = 5
	get_tree().reload_current_scene()


func _show_pause_menu() -> void:
	_pause_menu.visible = not _pause_menu.visible


func _on_crash_game() -> void:
	add_child(load("res://ui/crash_popup.tscn").instantiate())


func _show_settings_main() -> void:
	_settings_main.visible = true
	if _main_menu:
		_main_menu.visible = false
	#_main_menu.parallax_background.visible = false


func _show_main_menu() -> void:
	if _main_menu:
		_main_menu.visible = true
		_main_menu.parallax_background.visible = true
	_settings_main.visible = false


func _close_levels_menu() -> void:
	_levels_menu.visible = false
	_main_menu.visible = true


func _show_levels_menu() -> void:
	_levels_menu.visible = true
	_main_menu.visible = false
	_main_menu.parallax_background.visible = false


func _show_credits() -> void:
	_main_menu.visible = false
	_main_menu.parallax_background.visible = false
	var credits = load("res://ui/credits.tscn").instantiate()
	if credits == null:
		push_error("There's no credits scene by path %s" % "res://ui/credits.tscn")
	
	credits.show_main_menu.connect(_show_main_menu)
	
	add_child(credits)


func reset_main_menu(new_menu: MainMenu) -> void:
	_main_menu = new_menu
	#new_menu.show_settings_main.connect(_show_settings_main)
	#new_menu.show_levels_menu.connect(_show_levels_menu)
	#new_menu.show_credits.connect(_show_credits)
