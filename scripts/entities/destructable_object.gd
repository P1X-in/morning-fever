extends "res://scripts/entities/object.gd"

var hp = 1
var max_hp = 1
var vulnerable = true

var hit_sounds = ['punch1', 'punch2', 'punch3']

func _init(bag).(bag):
    self.bag = bag
    self.sounds['punch1'] = 'punch1'
    self.sounds['punch2'] = 'punch2'
    self.sounds['punch3'] = 'punch3'

func die():
    self.play_sound('die')
    self.despawn()

func get_hp():
    return self.hp

func set_hp(hp):
    if hp <= 0:
        self.die()
        return

    if hp <= self.max_hp:
        self.hp = hp
    else:
        self.hp = self.max_hp

func recieve_damage(damage):
    self.play_sound('hit')
    if self.vulnerable:
        self.set_hp(self.hp - damage)
        var i = randi() % self.hit_sounds.size()
        self.play_sound(self.hit_sounds[i])

func will_die(damage):
    return damage >= self.hp
