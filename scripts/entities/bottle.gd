
extends "res://scripts/entities/object.gd"

func _init(bag).(bag):
    self.avatar = preload("res://scenes/entities/bottle.tscn").instance()

