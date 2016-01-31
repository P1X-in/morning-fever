extends "res://scripts/entities/abstract_enemy.gd"

func _init(bag).(bag):
    self.avatar = preload("res://scenes/entities/rat3.tscn").instance()
    self.body = self.avatar.get_node('body')
    self.animations = self.avatar.get_node('anim')
    self.score = 120
    self.max_hp = 2
    self.hp = 2

func attack():
    .attack()
    self.animate('punch')