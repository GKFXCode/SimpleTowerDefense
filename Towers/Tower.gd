extends Node2D
class_name Tower

var built:bool = false
var ready:bool = true
var tower_type:String
var enemy_array = []
var enemy: Enemy = null

func _ready():
    get_node("Range/CollisionShape2D").get_shape().radius = 0.5*GameData.tower_data[tower_type]["range"] 
    print(get_node("Range/CollisionShape2D").get_shape().radius)

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
