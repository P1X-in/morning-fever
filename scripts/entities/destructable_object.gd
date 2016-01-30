extends "res://scripts/entities/object.gd"

var hp = 1
var max_hp = 1
var vulnerable = true

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

func will_die(damage):
    return damage >= self.hp
