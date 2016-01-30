extends "res://scripts/entities/abilities/melee.gd"

func _init(bag, using_entity).(bag, using_entity):
    self.power = 2
    self.cooldown = 0.3
    self.reach = 25
    self.push_back = true

func use():
    self.using_entity.animate('kick')
    .use()
