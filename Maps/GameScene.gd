extends Node2D

var level:int = 0 # 关卡
var level_stared:bool = false
var build_mode:bool = false
var build_valid:bool = false
var build_type:String
var build_location:Vector2
var build_tile
var base_health = 100
var money = 200

signal game_finished(result)
signal game_restart

onready var ui = get_node("UI")
onready var map_node = get_node("Map0")
onready var hp_bar = get_node("UI/HUD/InfoBar/HBoxContainer/HP")
onready var hp_bar_tween = get_node("UI/HUD/InfoBar/HBoxContainer/HP/Tween")
onready var money_label = get_node("UI/HUD/InfoBar/HBoxContainer/Money")
const preview_color = "ad54ff3c"

func _ready():
    money_label.text = str(money)
    for build_button in get_tree().get_nodes_in_group("build_buttons"):
        build_button.connect("pressed", self, "init_build_mode", [build_button.get_name()])
    
func _process(delta):
    if build_mode:
        update_tower_preview()
       
func _unhandled_input(event):
    if event.is_action_pressed("ui_cancel") and build_mode:
        cancel_build_mode()
    if event.is_action_released("ui_accept") and build_mode:
        verify_and_build()
        cancel_build_mode()
        
func cancel_build_mode():
    build_mode = false
    build_valid = false
    get_node("UI/TowerPreview").free()

func init_build_mode(tower_type:String):
    if build_mode:
        cancel_build_mode()
    build_type = tower_type + "T1"
    if GameData.tower_data[build_type].cost > money:
        return
    build_mode = true
    var tower = load("res://Towers/" + build_type + ".tscn").instance()
    tower.set_name("PreviewTower")
    tower.modulate = Color(preview_color)
    
    var scaling = GameData.tower_data[build_type]["range"]/600.0
    var range_texture = Sprite.new()
    range_texture.position = Vector2(32, 32)
    range_texture.texture = load("res://Assets/UI/range_overlay.png")
    range_texture.modulate = Color(preview_color)
    range_texture.scale = Vector2(scaling, scaling)
    
    var control = Control.new()
    control.add_child(tower, true)
    control.add_child(range_texture, true)
    
    control.rect_position = get_local_mouse_position()
    control.set_name('TowerPreview')
    ui.add_child(control, true)
    ui.move_child(control, 0) # 移动到最上层

  
func update_tower_preview():
    var mouse_position = get_global_mouse_position()
    var current_tile = map_node.get_node("TowerExclusion").world_to_map(mouse_position)
    var tile_position = map_node.get_node("TowerExclusion").map_to_world(current_tile)
    var color:String
    if map_node.get_node("TowerExclusion").get_cellv(current_tile) == -1:
        color = "ad54ff3c"
        build_valid = true
        build_location = tile_position
        build_tile = current_tile
    else:
        color = "adff4545"
        build_valid = false
    ui.get_node("TowerPreview").rect_position = tile_position
    if ui.get_node("TowerPreview/").modulate != Color(color):
        ui.get_node("TowerPreview/PreviewTower").modulate = Color(color)
        ui.get_node("TowerPreview/Sprite").modulate = Color(color)
      
func verify_and_build():
    if build_valid:
        var new_tower = load("res://Towers/" + build_type + ".tscn").instance()
        new_tower.position = build_location
        new_tower.built = true
        map_node.get_node("Towers").add_child(new_tower, true)
        map_node.get_node("TowerExclusion").set_cellv(build_tile, 6)
        money -= GameData.tower_data[build_type].cost
        money_label.text = str(money)


func _on_Pause_pressed():
    if build_mode:
        cancel_build_mode()
    if not level_stared:
        level_stared = true
        spawn_enemies()
    elif get_tree().is_paused():
        get_tree().paused = false
    else:
        get_tree().paused = true
    
func spawn_enemies():
    for i in range(10):
        var new_enemy = load("res://Enemies/BlueTank.tscn").instance()
        map_node.get_node("Path2D").add_child(new_enemy)
        new_enemy.connect("base_damage", self, "on_base_damage")
        yield(get_tree().create_timer(1), "timeout")
    
func _on_SpeedUP_pressed():
    if build_mode:
        cancel_build_mode()
    if Engine.get_time_scale() == 2.0:
        Engine.set_time_scale(1.0)
    else:
        Engine.set_time_scale(2.0)
        
        
func _on_Restart_pressed() -> void:
    print("emit restart")
    emit_signal("game_restart") 

func _on_Return_pressed() -> void:
    emit_signal("game_finished", false) 
    
func update_health_bar(base_health):
    hp_bar_tween.interpolate_property(hp_bar, "value", 
        hp_bar.value, base_health, 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
    hp_bar_tween.start()
    
func on_base_damage(damage):
    base_health -= damage
    if base_health <= 0:
        emit_signal("game_finished", false)
    else:
        update_health_bar(base_health)





