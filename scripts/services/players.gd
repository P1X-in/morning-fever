
var bag

var player_template = preload("res://scripts/entities/player.gd")
var players = []

func _init_bag(bag):
    self.bag = bag
    self.bind_players()

func bind_players():
    self.players = [
        self.player_template.new(self.bag, 0),
        self.player_template.new(self.bag, 1),
    ]

func get_next_free_player():
    for player in self.players:
        if not player.is_playing and players.is_alive:
            return player
    return null

func is_gamepad_in_use(id):
    for player in self.players:
        if player.gamepad_id == id:
            return true
    return false

func spawn_players():
    for player in self.players:
        player.enter_game()

func is_living_player_in_game():
    for player in self.players:
        if player.is_playing && player.is_alive:
            return true
    return false

func reset():
    for player in self.players:
        player.reset()