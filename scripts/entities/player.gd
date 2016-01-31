extends "res://scripts/entities/moving_object.gd"

var player_id
var gamepad_id = null
var keyboard_use = null
var score = 0

var is_playing = false
var is_alive = true
var is_invulnerable = false
var invulnerability_period = 0.5

var attack_range = 100
var camera_leash = 150

var attacks = {}
var attack_cooldown = 0.2
var is_attack_on_cooldown = false

var input_handlers = []
var key_handlers = []

func _init(bag, player_id).(bag):
    self.bag = bag
    self.player_id = player_id
    self.velocity = 32
    self.hp = 10
    self.max_hp = 10
    self.MOVEMENT_SPEED_CAP = 2.5
    self.free_avatar = false

    if player_id == 0:
        self.avatar = preload("res://scenes/entities/p1.tscn").instance()
    else:
        self.avatar = preload("res://scenes/entities/p2.tscn").instance()
    self.body = self.avatar.get_node('body')
    self.animations = self.avatar.get_node('anim')

    self.input_handlers = [
        preload("res://scripts/input/handlers/player_move_axis.gd").new(self.bag, self, 0),
        preload("res://scripts/input/handlers/player_move_axis.gd").new(self.bag, self, 1),
        preload("res://scripts/input/handlers/player_attack_gamepad.gd").new(self.bag, self, "kick", JOY_BUTTON_0),
        preload("res://scripts/input/handlers/player_attack_gamepad.gd").new(self.bag, self, "punch", JOY_BUTTON_1),
        preload("res://scripts/input/handlers/player_move_dpad.gd").new(self.bag, self, 1, JOY_DPAD_UP, -1),
        preload("res://scripts/input/handlers/player_move_dpad.gd").new(self.bag, self, 1, JOY_DPAD_DOWN, 1),
        preload("res://scripts/input/handlers/player_move_dpad.gd").new(self.bag, self, 0, JOY_DPAD_LEFT, -1),
        preload("res://scripts/input/handlers/player_move_dpad.gd").new(self.bag, self, 0, JOY_DPAD_RIGHT, 1),

    ]

    self.key_handlers = [
        preload("res://scripts/input/handlers/player_move_key.gd").new(self.bag, self, 1, KEY_W, -1),
        preload("res://scripts/input/handlers/player_move_key.gd").new(self.bag, self, 1, KEY_S, 1),
        preload("res://scripts/input/handlers/player_move_key.gd").new(self.bag, self, 0, KEY_A, -1),
        preload("res://scripts/input/handlers/player_move_key.gd").new(self.bag, self, 0, KEY_D, 1),
        preload("res://scripts/input/handlers/player_attack_keyboard.gd").new(self.bag, self, "kick", KEY_O),
        preload("res://scripts/input/handlers/player_attack_keyboard.gd").new(self.bag, self, "punch", KEY_P),
    ]

    self.attacks['punch'] = preload("res://scripts/entities/abilities/punch.gd").new(self.bag, self)
    self.attacks['kick'] = preload("res://scripts/entities/abilities/kick.gd").new(self.bag, self)

func bind_keyboard():
    var keyboard = self.bag.input.devices['keyboard']
    self.keyboard_use = true
    for handler in self.key_handlers:
        keyboard.register_handler(handler)
func unbind_keyboard():
    if not self.keyboard_use:
        return

    var keyboard = self.bag.input.devices['keyboard']
    self.keyboard_use = false
    for handler in self.key_handlers:
        keyboard.remove_handler(handler)

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

    self.gamepad_id = null

func enter_game():
    var entry_position
    self.is_playing = true
    entry_position = self.bag.camera.get_pos() + self.bag.positions.players[self.player_id]
    self.spawn(entry_position)
    self.bag.hud.update_player_hp(self.player_id, self.hp)

func spawn(position):
    self.is_alive = true
    .spawn(position)

func die():
    self.is_alive = false
    self.bag.action.player_died()
    .die()

func process(delta):
    if not self.is_processing:
        return
    .process(delta)
    self.handle_items()
    self.handle_animations()

func modify_position(delta):
    .modify_position(delta)
    self.handle_animations()

func apply_friction(current_motion, delta):
    var new_motion = .apply_friction(current_motion, delta)
    var camera_distance = self.calculate_distance_to_object(self.bag.camera)
    var direction = self.get_pos().x - self.bag.camera.get_pos().x

    if camera_distance > self.camera_leash:
        if direction < 0 and new_motion.x < 0:
            new_motion.x = 0
        elif direction > 0 and new_motion.x > 0:
            new_motion.x = 0

    return new_motion

func handle_collision(collider):
    return

func handle_animations():
    if not self.animations.is_playing() or self.animations.get_current_animation() == 'idle':
        if self.movement_vector[0] != 0 or self.movement_vector[1] != 0:
            self.animate('walk')
        else:
            if not self.animations.is_playing():
                self.animate('idle')
    if self.animations.get_current_animation() == 'walk' and self.movement_vector[0] == 0 and self.movement_vector[1] == 0:
        self.animate('idle')

func handle_items():
    if self.hp == self.max_hp:
        return

    var pickups = self.bag.items.find_pickups_in_range(self, 5, self.facing)
    for pickup in pickups:
        if self.hp == self.max_hp:
            break
        self.set_hp(self.hp + 1)
        self.bag.items.despawn_bottle(pickup)

func reset():
    self.hp = self.max_hp
    self.is_playing = false
    self.is_alive = true
    self.movement_vector = [0, 0]
    self.controller_vector = [0, 0]
    self.score = 0
    self.is_attack_on_cooldown = false
    self.is_stunned = false
    self.can_move = true
    self.is_invulnerable = false
    self.unbind_gamepad()
    self.unbind_keyboard()
    self.despawn()
    self.animations.stop()

func attack(ability_name):
    if self.is_attack_on_cooldown:
        return

    self.attacks[ability_name].use()
    self.is_attack_on_cooldown = true
    self.can_move = false
    self.bag.timers.set_timeout(self.attacks[ability_name].cooldown, self, "attack_cooled_down")
    self.is_invulnerable = true
    self.bag.timers.set_timeout(0.1, self, "loose_invulnerability")

func attack_cooled_down():
    self.is_attack_on_cooldown = false
    self.can_move = true

func recieve_damage(damage):
    if self.is_invulnerable:
        return

    self.is_invulnerable = true
    .recieve_damage(damage)
    self.bag.timers.set_timeout(self.invulnerability_period, self, "loose_invulnerability")

func loose_invulnerability():
    self.is_invulnerable = false

func set_hp(hp):
    if hp < 0:
        hp = 0
    self.bag.hud.update_player_hp(self.player_id, hp)
    .set_hp(hp)