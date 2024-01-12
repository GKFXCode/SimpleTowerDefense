extends Tower

var Missile = preload("res://Bullets/Missile.tscn")

func _init():
    tower_type = "MissileT1"

func set_ready():
    ready = true
    
func fire():
    print('fire')
    ready = false
    get_node("AnimationPlayer").play("fire")
    var missile1 = Missile.instance()
    var missile2 = Missile.instance()
    missile1.position = get_node("Turret/Missile1").position
    missile2.position = get_node("Turret/Missile2").position
    add_child(missile1)
    add_child(missile2)
    missile1.launch_at(enemy)
    missile2.launch_at(enemy)
    yield(get_tree().create_timer(GameData.tower_data[tower_type]["rof"]), "timeout")
    get_node("AnimationPlayer").play("ready")
