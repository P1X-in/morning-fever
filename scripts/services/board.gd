extends "res://scripts/services/abstract_screen.gd"

var board = preload("res://scenes/map/board.tscn")

func _init():
    self.screen_scene = preload("res://scenes/map/board.tscn").instance()

func attach_object(object):
    return

func detach_object():
    return