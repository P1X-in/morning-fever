extends "res://scripts/services/abstract_screen.gd"

var board = preload("res://scenes/map/board.tscn")
var mount

var current_map = null

func _init():
    self.screen_scene = preload("res://scenes/map/board.tscn").instance()
    self.mount = self.screen_scene.get_node('mount')

func load_map(name):
    self.unload_map()
    self.current_map = self.bag.maps.maps[name]
    if not self.mount.is_a_parent_of(self.current_map):
        self.mount.add_child(self.current_map)

func unload_map():
    if current_map == null:
        return

    if self.mount.is_a_parent_of(self.current_map):
        self.mount.remove_child(self.current_map)
    self.current_map = null

func attach_object(object):
    return

func detach_object():
    return