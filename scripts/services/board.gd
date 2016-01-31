extends "res://scripts/services/abstract_screen.gd"

var board = preload("res://scenes/map/board.tscn")
var mount
var hud

var current_map_data
var current_map = null

var attached_objects = {}

var battles = []
var time_left

func _init():
    self.screen_scene = preload("res://scenes/map/board.tscn").instance()
    self.mount = self.screen_scene.get_node('mount')
    self.hud = self.screen_scene.get_node('hud')

func reset():
    self.clear_all_objects()
    self.unload_map()
    self.current_map_data = null
    self.battles = []

func load_map(name):
    self.unload_map()
    self.current_map_data = self.bag.maps.maps[name]
    self.current_map = self.current_map_data.scene
    if not self.mount.is_a_parent_of(self.current_map):
        self.mount.add_child(self.current_map)
    self.queue_battles()
    self.time_left = self.current_map_data.time_limit

func unload_map():
    if current_map == null:
        return

    if self.mount.is_a_parent_of(self.current_map):
        self.mount.remove_child(self.current_map)
    self.current_map = null
    self.battles = []

func queue_battles():
    for battle in self.current_map_data.battles:
        self.battles.append({
            'distance' : battle['distance'],
            'waves' : battle['waves'],
            'done' : false
        })

func attach_object(object):
    if self.current_map == null or not self.mount.is_a_parent_of(self.current_map) or self.current_map.is_a_parent_of(object):
        return

    self.attached_objects[object.get_instance_ID()] = object
    self.current_map.get_node('ysort').add_child(object)

func detach_object(object):
    if self.current_map == null or not self.mount.is_a_parent_of(self.current_map) or not self.current_map.is_a_parent_of(object):
        return

    self.attached_objects.erase(object.get_instance_ID())
    self.current_map.get_node('ysort').remove_child(object)

func clear_all_objects():
    for object in self.attached_objects:
        self.current_map.remove_child(self.attached_objects[object])
    self.attached_objects.clear()