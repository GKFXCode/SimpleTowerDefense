extends Tower

func _init():
    tower_type = "GunT1"
    

    
func fire():
    ready = false
    get_node("AnimationPlayer").play("fire")
    enemy.on_hit(GameData.tower_data[tower_type]["damage"], tower_type)
    yield(get_tree().create_timer(GameData.tower_data[tower_type]["rof"]), "timeout")
    ready = true
