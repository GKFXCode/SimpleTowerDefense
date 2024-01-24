extends Tower

export(float) var frozen_ratio:float = 0.5
export(int) var frozen_time: int = 5
export(int) var damage = 1

func _init():
    tower_type = "IceT1"
    
func fire():
    select_enemy()       
    enemy.frozen_ratio = frozen_ratio
    if not enemy.has_node("Frozen_timer"):
        var frozen_timer = Timer.new()
        frozen_timer.set_wait_time(frozen_time)
        frozen_timer.set_one_shot(true)
        frozen_timer.name = "Frozen_timer"
        enemy.add_child(frozen_timer,true)
    
    enemy.on_hit(damage, tower_type)
    

    
#func select_enemy():
#    pass
    
#func turn():
#    pass
