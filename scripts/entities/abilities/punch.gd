extends "res://scripts/entities/abilities/melee.gd"

func _init(bag, using_entity).(bag, using_entity):
    self.power = 1
    self.cooldown = 0.2
    self.reach = 15
    self.push_back = true

func use():
    self.using_entity.animate('punch')
    .use()
