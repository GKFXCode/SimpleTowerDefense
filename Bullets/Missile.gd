extends Node2D

var missile_speed:int = 0
var direction: Vector2 = Vector2.ZERO
var exploded:bool = false
const SPEED = 500
const DAMAGE = 500
var target

func aim(tareget_dir):
    var cur_dir = Vector2(1, 0)
    rotation = cur_dir.angle_to(tareget_dir)

func launch_at(target_):
    target = target_
    target.connect("dead", self, "explosion")
    missile_speed = SPEED
    
func launch(dir):
    aim(dir)
    direction = dir
    
func explosion():
    exploded = true
    missile_speed = 0
    direction = Vector2.ZERO
    get_node("AnimationPlayer").play("explosion")
    
    
func _physics_process(delta):
    if not exploded and target != null:
        launch((target.global_position - global_position).normalized())
        
    position += direction*missile_speed*delta


func _on_HitBox_body_entered(body):
    if body != null:
        get_node("HitBox").set_collision_mask_bit(1, false)
        body.get_parent().on_hit(GameData.tower_data["MissileT1"]["damage"], "MissileT1")
        explosion()
        

        
        
