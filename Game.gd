extends Node2D

var game_scene
func _init() -> void:
    var screen_size: Vector2 = OS.get_screen_size()
    var window_size: Vector2 = OS.get_window_size()
    
    OS.set_window_position(screen_size * 0.5 - window_size * 0.5)

func _ready():
    load_main_menu()
    
func load_main_menu():
    get_node("MainMenu/M/VB/NewGame").connect("pressed", self, "on_new_game_pressed")
    get_node("MainMenu/M/VB/Quit").connect("pressed", self, "on_quit_pressed")
    
func on_new_game_pressed():
    get_node("MainMenu").queue_free()
    game_scene = load("res://Maps/GameScene.tscn").instance()
    game_scene.connect("game_finished", self, "unload_game")
    game_scene.connect("game_restart", self, "restart_game")
    add_child(game_scene)

func one_quit_pressed():
    get_tree().quit()
    
func unload_game(result):
    game_scene.queue_free()
    var main_menu = load("res://MainMenu.tscn").instance()
    add_child(main_menu)
    load_main_menu()
    
func restart_game():
    print("restart")
    game_scene.queue_free()
    game_scene = load("res://Maps/GameScene.tscn").instance()
    game_scene.connect("game_finished", self, "unload_game")
    game_scene.connect("game_restart", self, "restart_game")
    add_child(game_scene)
    game_scene.set_name("GameScene")
