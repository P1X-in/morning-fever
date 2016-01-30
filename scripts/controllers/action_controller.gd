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
    self.bag.processing.register(self)

func end_game():
    self.bag.processing.remove(self)
    self.bag.board.detach()
    self.bag.board.unload_map()
    self.bag.intro.attach()
    self.is_game_in_progress = false

func process(delta):
    self.track_battles()

func track_battles():
    if not self.is_game_in_progress:
        return

    if self.bag.battle.in_progress and self.bag.enemies.no_enemies():
        self.bag.battle.spawn_next_wave()

    var distance = self.bag.camera.get_pos().x

    for battle in self.bag.board.battles:
        if battle['done']:
            continue
        if battle['distance'] <= distance:
            self.bag.battle.start(battle)