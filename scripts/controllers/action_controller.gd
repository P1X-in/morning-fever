var bag

func _init_bag(bag):
    self.bag = bag

func start_game():
    self.bag.intro.detach()
    self.bag.board.attach()
    self.bag.board.load_map('map1')