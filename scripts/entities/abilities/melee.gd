extends "res://scripts/entities/abilities/abstract_ability.gd"

var reach = 0
var power = 0
var push_back = false
var stun_duration = 0.25

func _init(bag, using_entity).(bag, using_entity):
    pass

func use():
    var enemies = self.find_enemies_in_range()

    for enemy in enemies:
        enemy.recieve_damage(self.power)
        enemy.stun(self.stun_duration)

        if self.push_back:
            enemy.push_back(self.using_entity, self.power)

func find_enemies_in_range():
    return self.bag.enemies.find_enemies_in_range(self.using_entity, self.reach, self.using_entity.facing)
