extends "res://scripts/input/handlers/gamepad_handler.gd"

var bag
var player
var ability_name

func _init(bag, player, ability_name):
    self.bag = bag
    self.player = player
    self.ability_name = ability_name
    self.type = InputEvent.JOYSTICK_BUTTON
    self.button_index = JOY_XBOX_B

func handle(event):
    if event.is_pressed() && self.bag.game_state.game_in_progress && self.player.is_playing && self.player.is_alive:
        self.player.attack()