
var bag

var devices = {
    "keyboard" : preload("res://scripts/input/keyboard.gd").new(),
    "mouse" : preload("res://scripts/input/mouse.gd").new(),
    #"arcade" : preload("res://scripts/input/arcade.gd").new(),
    "pad0" : preload("res://scripts/input/gamepad.gd").new(0),
    "pad1" : preload("res://scripts/input/gamepad.gd").new(1),
    "pad2" : preload("res://scripts/input/gamepad.gd").new(2),
    "pad3" : preload("res://scripts/input/gamepad.gd").new(3),
    "pad4" : preload("res://scripts/input/gamepad.gd").new(4),
    "pad5" : preload("res://scripts/input/gamepad.gd").new(5),
}

func _init_bag(bag):
    self.bag = bag
    self.load_basic_input()

func handle_event(event):
    for device in self.devices:
        if self.devices[device].can_handle(event):
            self.devices[device].handle_event(event)

func load_basic_input():
    self.devices['keyboard'].register_handler(preload("res://scripts/input/handlers/quit_game.gd").new())
    self.devices['keyboard'].register_handler(preload("res://scripts/input/handlers/start_game_key.gd").new(self.bag))

    #self.devices['arcade'].register_handler(preload("res://scripts/input/handlers/end_game_arcade.gd").new(self.bag))
    #self.devices['arcade'].register_handler(preload("res://scripts/input/handlers/start_game_arcade.gd").new(self.bag))
