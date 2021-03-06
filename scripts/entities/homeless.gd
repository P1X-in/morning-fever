extends "res://scripts/entities/abstract_enemy.gd"

func _init(bag).(bag):

    self.avatar = preload("res://scenes/entities/homeless.tscn").instance()
    self.body = self.avatar.get_node('body')
    self.animations = self.avatar.get_node('anim')
    self.score = 120
    self.max_hp = 3
    self.hp = 3
    self.drops_bottle = true

func attack():
    .attack()
    if randf() < 0.4:
        self.animate('kick')
    else:
        self.animate('punch')