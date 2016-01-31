extends "res://scripts/entities/abilities/abstract_ability.gd"

var reach = 0
var power = 0
var push_back = false
var stun_duration = 0.25

var sounds = ['attack1', 'attack2']

func _init(bag, using_entity).(bag, using_entity):
    pass

func use():
    var enemies = self.find_enemies_in_range()
    var items = self.find_items_in_range()

    for enemy in enemies:
        enemy.recieve_damage(self.power)
        enemy.stun(self.stun_duration)

        if self.push_back:
            enemy.push_back(self.using_entity, self.power)

    for item in items:
        item.hit()

    self.play_sound()

func play_sound():
    var i = randi() % self.sounds.size()
    self.bag.sound.play(self.sounds[i])


func find_enemies_in_range():
    return self.bag.enemies.find_enemies_in_range(self.using_entity, self.reach, self.using_entity.facing)

func find_items_in_range():
    return self.bag.items.find_items_in_range(self.using_entity, self.reach, self.using_entity.facing)
