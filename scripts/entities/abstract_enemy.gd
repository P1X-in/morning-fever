extends "res://scripts/entities/moving_object.gd"

var destination = [0, 0]
var target = null
var aggro_range = 500
var attack_range = 10
var attack_strength = 1
var attack_cooldown = 2
var is_attack_on_cooldown = false
var score = 0

func _init(bag).(bag):
    self.velocity = 30
    self.MOVEMENT_SPEED_CAP = 3

func go_to(x, y):
    self.destination[0] = x
    self.destination[1] = y

func process_ai():
    var distance
    var direction = Vector2(0, 0)

    if self.target == null:
        for player in self.bag.players.players:
            if player.is_playing && player.is_alive:
                distance = self.calculate_distance_to_object(player)
                if distance < self.aggro_range:
                    if self.target != null:
                        if self.calculate_distance_to_object(self.target) > distance:
                            self.target = player
                    else:
                        self.target = player
        if self.target == null:
            distance = self.calculate_distance(self.initial_position)
            if distance > 10:
                direction = self.cast_movement_vector(self.initial_position)
                direction = self.randomize_movement_vector(direction)
    else:
        distance = self.calculate_distance_to_object(self.target)
        if not self.target.is_alive || distance > self.aggro_range:
            self.target = null
        elif distance > self.attack_range:
            direction = self.cast_movement_vector(self.target.get_pos())
        elif not self.is_attack_on_cooldown:
            self.attack()

    self.movement_vector[0] = direction.x
    self.movement_vector[1] = direction.y

func cast_movement_vector(destination_point):
    var my_position = self.get_pos()
    var distance = self.calculate_distance(destination_point)
    var scale = 1.0 / distance
    var delta_x = (destination_point.x - my_position.x) * scale
    var delta_y = (destination_point.y - my_position.y) * scale

    return Vector2(delta_x, delta_y)

func randomize_movement_vector(vector):
    var range_x = vector.x / 10
    var range_y = vector.y / 10

    randomize()

    return Vector2(vector.x + rand_range(0, range_x), vector.y + rand_range(0, range_y))

func process(delta):
    if not self.is_processing:
        return

    self.reset_movement()
    self.process_ai()
    .process(delta)
    self.handle_animations()

func handle_animations():
    if not self.animations.is_playing() or self.animations.get_current_animation() == 'idle':
        if self.movement_vector[0] != 0 or self.movement_vector[1] != 0:
            self.animate('walk')
        else:
            if not self.animations.is_playing():
                self.animate('idle')

func apply_axis_threshold(axis_value):
    return axis_value

func attack():
    self.play_sound('attack')
    self.is_attack_on_cooldown = true
    self.target.push_back(self)
    self.target.recieve_damage(self.attack_strength)
    self.target.stun()
    self.bag.timers.set_timeout(self.attack_cooldown, self, "attack_cooled_down")

func attack_cooled_down():
    self.is_attack_on_cooldown = false

func die():
    self.bag.enemies.del_enemy(self)
    .die()

func stun(duration=null):
    .stun(duration)
    self.avatar.set_opacity(1)
    self.animations.play('hit')

func remove_stun():
    .remove_stun()
    self.avatar.set_opacity(1)
    self.animations.play('run')