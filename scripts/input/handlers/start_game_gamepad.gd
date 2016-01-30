extends "res://scripts/input/handlers/gamepad_handler.gd"

var bag

func _init(bag):
    self.bag = bag
    self.type = InputEvent.JOYSTICK_BUTTON
    self.button_index = JOY_BUTTON_7

func handle(event):
    if event.is_pressed() and not self.bag.action.is_game_in_progress:
        self.bag.action.start_game()