extends "res://scripts/input/handlers/gamepad_handler.gd"

var bag

func _init(bag):
    self.bag = bag
    self.type = InputEvent.JOYSTICK_BUTTON
    self.button_index = JOY_BUTTON_7

func handle(event):
    if event.is_pressed() and self.bag.action.is_game_in_progress:
        if self.bag.players.is_gamepad_in_use(event.device):
            return

        var player = self.bag.players.get_next_free_player()
        if player == null:
            return

        player.bind_gamepad(event.device)
        player.enter_game()