
var bag

var current_battle
var in_progress = false
var wave = 0

func _init_bag(bag):
    self.bag = bag

func start(battle):
    self.current_battle = battle
    self.current_battle['done'] = true
    self.in_progress = true
    self.wave = 0
    self.bag.camera.lock()

func spawn_next_wave():
    if self.wave >= self.current_battle['waves'].size():
        self.end()
        return

    self.bag.enemies.spawn_wave(self.current_battle['waves'][self.wave])

    self.wave = self.wave + 1

func end():
    self.in_progress = false
    self.bag.camera.unlock()

func reset():
    self.in_progress = false
    self.current_battle = null
    self.wave = 0