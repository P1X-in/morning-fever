
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