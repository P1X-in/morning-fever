extends "res://scripts/entities/abstract_enemy.gd"

func _init(bag).(bag):
    self.avatar = preload("res://scenes/entities/rat2.tscn").instance()
    self.body = self.avatar.get_node('body')
    self.animations = self.avatar.get_node('anim')
    self.score = 120
    self.max_hp = 1
    self.hp = 1
    self.dying_sounds = ['rat_die']
    for cry in self.dying_sounds:
        self.sounds[cry] = cry

func attack():
    .attack()
    self.animate('punch')