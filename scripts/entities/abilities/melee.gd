extends "res://scripts/entities/abilities/abstract_ability.gd"

var reach = 0
var power = 0
var push_back = false
var stun_duration = 0.25

func _init(bag, using_entity).(bag, using_entity):
    pass

func use():
    var enemy = self.find_closest_enemy_in_range()

    if enemy != null:
        enemy.recieve_damage(self.power)
        enemy.stun(self.stun_duration)

        if self.push_back:
            enemy.push_back(self.using_entity, self.power)

func find_closest_enemy_in_range():
    return self.bag.enemies.find_closest_enemy(self.using_entity, self.reach, self.using_entity.facing)
