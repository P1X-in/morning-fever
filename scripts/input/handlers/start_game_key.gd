extends "res://scripts/input/handlers/keyboard_handler.gd"

var bag

func _init(bag):
    self.bag = bag
    self.scancode = KEY_RETURN

func handle(event):
    if event.is_pressed():
        self.bag.action.start_game()