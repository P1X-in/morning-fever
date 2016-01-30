var bag
var mount

func _ready():
    self.mount = self.get_node("/root/game")
    self.bag = preload("res://scripts/services/dependency_bag.gd").new(self)
    self.set_process_input(true)
    self.set_fixed_process(true)

    self.bag.intro.attach()

func _input(event):
    self.bag.input.handle_event(event)