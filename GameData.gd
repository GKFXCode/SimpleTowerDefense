extends Node

var tower_data = {
    "GunT1":{
        "damage":20, "rof":1, "range":350, "category":"Projecttile", "cost":10},
    "MissileT1":{
        "damage":100, "rof":3, "range":550, "category":"Missile", "cost":50},
    "GunT2":{
        "damage":50, "rof":1, "range":350, "category":"Projecttile", "cost":50},
    "BombT1":{
        "damage":20, "rof":1, "range":350, "category":"Projecttile", "cost":10
       },
    "IceT1":{
        "damage":0, "rof":1, "range":350, "category":"Projecttile", "cost":10
       },
    "FlamethrowerT1":{
        "damage":20, "rof":3, "range":350, "category":"Projecttile", "cost":10
       },
    "SummoningT1":{
        "damage":20, "rof":3, "range":250, "category":"Projecttile", "cost":10
       }
}

var enemy_data = {
    "BlueTank":{
        "base_damage":10, "speed":150, "hp":200
       }
   }
