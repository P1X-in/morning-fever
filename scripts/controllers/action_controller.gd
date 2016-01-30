var bag

var is_game_in_progress = false

func _init_bag(bag):
    self.bag = bag

func start_game():
    self.bag.intro.detach()
    self.bag.board.attach()
    self.bag.board.load_map('map1')
    self.bag.camera.attach()
    self.is_game_in_progress = true