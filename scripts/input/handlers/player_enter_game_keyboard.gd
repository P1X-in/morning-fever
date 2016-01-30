extends "res://scripts/input/handlers/keyboard_handler.gd"

var bag

func _init(bag):
    self.bag = bag
    self.scancode = KEY_SPACE

func handle(event):
    if event.is_pressed() and self.bag.action.is_game_in_progress:
        var player = self.bag.players.get_next_free_player()
        if player == null:
            return

        player.bind_keyboard()
        player.enter_game()