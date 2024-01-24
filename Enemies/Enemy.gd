extends PathFollow2D
class_name Enemy

var type:String
var speed:int
var hp:int
var base_damage:int
var origin_speed: int
var frozen_ratio: float = 1.0

# 状态
var ignited:bool = false
var frozen:bool = false

onready var healthbar = get_node("HealthBar")
onready var impact_area = get_node("Impact")


var projecttile_impact = preload("res://Bullets/ProjecttileImpact.tscn") 
signal dead
signal base_damage(damage)

func _physics_process(delta):
    if unit_offset >= 0.99:
        print('base damage')
        emit_signal("base_damage", base_damage)
        emit_signal("dead")
        self.queue_free()
    move(delta)

func move(delta):
    set_offset(get_offset() + speed * delta)
    healthbar.set_position(position - Vector2(30, 30))
    
func die():
    emit_signal("dead")
    get_node("KinematicBody2D").queue_free()
    yield(get_tree().create_timer(0.2), "timeout")
    self.queue_free()
    
func on_hit(damage:int, tower_type:String):
    hp -= damage
    healthbar.value = hp
    hit_effect(tower_type)
    if hp <= 0:
        die()
        
func hit_effect(tower_type:String):
    if tower_type == "GunT1":
        randomize()
        var x_pos = randi()%31
        randomize()
        var y_pos = randi()%31
        var impact_loaction = Vector2(x_pos, y_pos)
        var new_impact  = projecttile_impact.instance()
        new_impact.position = impact_loaction
        impact_area.add_child(new_impact)
    elif tower_type == "IceT1":
        var frozen_timer:Timer = get_node("Frozen_timer")
        frozen_timer.connect("timeout", self, "_on_frozen_timer_timeout")
        if not frozen:
            frozen = true
            origin_speed = speed
            speed = speed * frozen_ratio
            frozen_timer.start()
        else:
            frozen_timer.stop()
            frozen_timer.start()
            
func _on_frozen_timer_timeout():
    if frozen:
        frozen = false
        speed = origin_speed    
