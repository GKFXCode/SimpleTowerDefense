extends Enemy

func _init():
    type = "BlueTank"
    hp = GameData.enemy_data[type]["hp"]
    speed = GameData.enemy_data[type]["speed"]
    base_damage = GameData.enemy_data[type]["base_damage"]
    
func _ready():
    healthbar.max_value = hp
    healthbar.value = hp
    healthbar.set_as_toplevel(true)
