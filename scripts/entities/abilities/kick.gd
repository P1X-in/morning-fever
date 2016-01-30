extends "res://scripts/entities/abilities/abstract_ability.gd"

func _init(bag, using_entity).(bag, using_entity):
    pass

func use():
    self.using_entity.animate('kick')
