extends Node2D
class_name Tower

var built:bool = false
var ready:bool = true
var tower_type:String
var enemy_array = []
var enemy: Enemy = null
onready var range_texture = get_node("Range/Sprite")

func _ready():
    get_node("Range/CollisionShape2D").get_shape().radius = 0.5*GameData.tower_data[tower_type]["range"] 
    var scaling = GameData.tower_data[tower_type]["range"]/600.0
    range_texture.scale = Vector2(scaling, scaling)

func _physics_process(delta):
    if not enemy_array.empty() and built:
        select_enemy()
        if not get_node("AnimationPlayer").is_playing():
            turn()
        if ready:
            fire()
    else:
        enemy = null
        
func fire():
    print('fire')

func select_enemy():
    var enemy_progress_array = []
    for i in enemy_array:
        enemy_progress_array.append(i.offset)
    var max_offset = enemy_progress_array.max()
    var enemy_index = enemy_progress_array.find(max_offset)
    enemy = enemy_array[enemy_index]
        
func turn():
    get_node("Turret").look_at(enemy.position)
    
func _on_Range_body_entered(body):
    enemy_array.append(body.get_parent())


func _on_Range_body_exited(body):
    enemy_array.erase(body.get_parent())


func _on_SelectArea_mouse_entered() -> void:
    range_texture.visible = true


func _on_SelectArea_mouse_exited() -> void:
    range_texture.visible = false
