extends "res://scripts/input/handlers/gamepad_handler.gd"

var bag
var player
var ability_name

func _init(bag, player, ability_name, key):
    self.bag = bag
    self.player = player
    self.ability_name = ability_name
    self.type = InputEvent.JOYSTICK_BUTTON
    self.button_index = key

func handle(event):
    if event.is_pressed() && self.bag.action.is_game_in_progress && self.player.is_playing && self.player.is_alive:
        self.player.attack(self.ability_name)