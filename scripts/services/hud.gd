extends "res://scripts/services/abstract_screen.gd"

var time_label

func _init_bag(bag, container):
    ._init_bag(bag, container)
    self.screen_scene = self.bag.board.screen_scene.get_node('hud')
    self.time_label = self.screen_scene.get_node('time/time_string')

func set_timer(time_left):
    self.time_label.set_text(str(time_left))

func update_timer():
    self.set_timer(self.bag.board.time_left)