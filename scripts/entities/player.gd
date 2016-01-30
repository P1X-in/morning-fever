extends "res://scripts/entities/moving_object.gd"

var player_id
var gamepad_id = null
var score = 0

var is_playing = false
var is_alive = true

var attack_range = 100

var attacks = {}
var is_attack_on_cooldown = false

var input_handlers = [
    #preload("res://scripts/input/handlers/player_enter_game_gamepad.gd").new(self.bag, self),
    #preload("res://scripts/input/handlers/player_move_axis.gd").new(self.bag, self, 0),
    #preload("res://scripts/input/handlers/player_move_axis.gd").new(self.bag, self, 1),
    #preload("res://scripts/input/handlers/player_cone_gamepad.gd").new(self.bag, self, 0, Globals.get("platform_input/xbox_right_stick_x")),
    #preload("res://scripts/input/handlers/player_cone_gamepad.gd").new(self.bag, self, 1, Globals.get("platform_input/xbox_right_stick_y")),
    #preload("res://scripts/input/handlers/player_attack_gamepad.gd").new(self.bag, self)
]

func _init(bag, player_id).(bag):
    self.bag = bag
    self.player_id = player_id
    self.velocity = 50
    self.hp = 10
    self.max_hp = 10

    self.avatar = preload("res://scenes/entities/bum.tscn").instance()

func bind_gamepad(id):
    self.unbind_gamepad()
    self.gamepad_id = id
    var gamepad = self.bag.input.devices['pad' + str(id)]

    for handler in self.input_handlers:
        gamepad.register_handler(handler)

func unbind_gamepad():
    if self.gamepad_id == null:
        return

    var gamepad = self.bag.input.devices['pad' + str(self.gamepad_id)]

    for handler in self.input_handlers:
        gamepad.remove_handler(handler)

func enter_game():
    self.is_playing = true
    self.spawn(self.bag.positions.players[self.player_id])

func spawn(position):
    self.is_alive = true
    .spawn(position)

func die():
    self.is_alive = false
    .die()

func process(delta):
    .process(delta)
    self.handle_items()

func modify_position(delta):
    .modify_position(delta)
    self.handle_animations()

func handle_collision(collider):
    return

func handle_animations():
    return


func handle_items():
    return

func attack():
    if self.is_attack_on_cooldown:
        return

    return

func check_colisions():
    return

func recieve_damage(damage):
    #self.bag.camera.shake()
    .recieve_damage(damage)

func reset():
    self.hp = self.max_hp
    self.is_playing = false
    self.is_alive = true
    self.movement_vector = [0, 0]
    self.controller_vector = [0, 0]
    self.score = 0
    self.is_attack_on_cooldown = false
    self.despawn()

func attack_cooled_down():
    self.is_attack_on_cooldown = false
