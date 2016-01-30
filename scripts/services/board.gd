extends "res://scripts/services/abstract_screen.gd"

var board = preload("res://assets/map/board.tscn")

func _init():
    self.screen_scene = preload("res://assets/map/board.tscn").instance()

func attach_object(object):
    return

func detach_object():
    return