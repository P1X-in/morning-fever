extends "res://scripts/input/handlers/keyboard_handler.gd"

var bag
var player
var axis
var direction

func _init(bag, player, axis, key, direction):
    self.bag = bag
    self.player = player
    self.scancode = key
    self.axis = axis
    self.direction = direction

func handle(event):
    if event.is_echo():
        return
    if event.is_pressed() && self.bag.action.is_game_in_progress && self.player.is_playing && self.player.is_alive:
        self.player.controller_vector[self.axis] = self.player.controller_vector[self.axis] + self.direction
        if abs(self.player.controller_vector[self.axis]) > abs(self.direction):
            self.player.controller_vector[self.axis] = self.direction

    if not event.is_pressed() && self.bag.action.is_game_in_progress && self.player.is_playing && self.player.is_alive:
        self.player.controller_vector[self.axis] = self.player.controller_vector[self.axis] - self.direction