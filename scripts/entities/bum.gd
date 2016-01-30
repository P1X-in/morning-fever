extends "res://scripts/entities/abstract_enemy.gd"

func _init(bag).(bag):
    self.avatar = preload("res://scenes/entities/bum.tscn").instance()
    self.body = self.avatar.get_node('body')
    self.animations = self.avatar.get_node('anim')
    self.score = 120