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
    self.bag.hud.update_timer()
    self.bag.timers.set_timeout(1, self, "track_time")
    self.bag.sound.play_soundtrack('street')
    self.bag.hud.show_arrow()
    self.bag.hud.hide_loose()

func end_game():
    self.is_game_in_progress = false
    self.bag.processing.remove(self)
    self.bag.board.detach()
    self.bag.intro.attach()
    self.bag.reset()
    self.bag.sound.play_soundtrack('menu')

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

func track_time():
    if not self.is_game_in_progress:
        return

    if self.bag.board.time_left < 1:
        self.is_game_in_progress = false
        self.bag.enemies.stop_processing()
        self.bag.players.stop_processing()
        self.bag.hud.hide_arrow()
        self.bag.hud.show_loose()
        self.bag.sound.play_soundtrack('over')
        self.bag.timers.set_timeout(3, self, "end_game")
        return

    if self.bag.players.is_living_player_in_game():
        self.bag.board.time_left = self.bag.board.time_left - 1
        self.bag.hud.update_timer()

    self.bag.timers.set_timeout(1, self, "track_time")

func player_died():
    if not self.bag.players.is_living_player_in_game():
        self.bag.hud.hide_arrow()
        self.bag.hud.show_loose()
        self.bag.sound.play_soundtrack('over')
        self.bag.timers.set_timeout(3, self, "end_game")