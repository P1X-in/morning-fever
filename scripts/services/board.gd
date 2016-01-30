extends "res://scripts/services/abstract_screen.gd"

var board = preload("res://scenes/map/board.tscn")
var mount

var current_map = null

var attached_objects = {}

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
    if self.current_map == null or not self.mount.is_a_parent_of(self.current_map) or self.current_map.is_a_parent_of(object):
        return

    self.attached_objects[object.get_instance_ID()] = object
    self.current_map.add_child(object)

func detach_object(object):
    if self.current_map == null or not self.mount.is_a_parent_of(self.current_map) or not self.current_map.is_a_parent_of(object):
        return

    self.attached_objects.erase(object.get_instance_ID())
    self.current_map.remove_child(object)

func clear_all_objects():
    for object in self.attached_objects:
        self.current_map.remove_child(self.attached_objects[object])
    self.attached_objects.clear()