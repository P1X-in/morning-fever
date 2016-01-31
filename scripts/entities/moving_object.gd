extends "res://scripts/entities/destructable_object.gd"

var body
var animations
var velocity
var movement_vector = [0, 0]
var controller_vector = [0, 0]
var facing = 1

var AXIS_THRESHOLD = 0.15

var FLOOR_FRICTION = 25
var MOVEMENT_SPEED_CAP = 4

var can_move = true
var stun_duration = 0.25
var is_stunned = false

func _init(bag).(bag):
    self.bag = bag

func spawn(position):
    .spawn(position)
    self.bag.processing.register(self)

func despawn():
    self.bag.processing.remove(self)
    .despawn()

func process(delta):
    self.modify_position(delta)

func modify_position(delta):
    if not self.can_move:
        return

    var x = self.apply_axis_threshold(self.controller_vector[0])
    var y = self.apply_axis_threshold(self.controller_vector[1])

    var current_motion = Vector2(self.movement_vector[0], self.movement_vector[1])
    var motion_delta = Vector2(x, y) * self.velocity * delta

    current_motion = current_motion + motion_delta


    var speed_cap = self.MOVEMENT_SPEED_CAP
    if abs(current_motion.x) > speed_cap:
        if current_motion.x < 0:
            current_motion.x = -speed_cap
        else:
            current_motion.x = speed_cap

    if abs(current_motion.y) > speed_cap:
        if current_motion.y < 0:
            current_motion.y = -speed_cap
        else:
            current_motion.y = speed_cap

    if current_motion == Vector2(0, 0):
        return

    current_motion = self.apply_friction(current_motion, delta)
    current_motion.y = current_motion.y * 0.9

    self.avatar.move(current_motion)
    if (self.avatar.is_colliding()):
        var collider = self.avatar.get_collider()
        var normal = self.avatar.get_collision_normal()
        current_motion = normal.slide(current_motion)
        self.avatar.move(current_motion)
        self.handle_collision(collider)
    self.flip(self.movement_vector[0])
    self.movement_vector[0] = current_motion.x
    self.movement_vector[1] = current_motion.y

func handle_collision(collider):
    return

func apply_friction(current_motion, delta):
    if abs(current_motion.x) < self.FLOOR_FRICTION * delta:
        current_motion.x = 0
    else:
        if current_motion.x > 0:
            current_motion.x = current_motion.x - self.FLOOR_FRICTION * delta
        else:
            current_motion.x = current_motion.x + self.FLOOR_FRICTION * delta
    if abs(current_motion.y) < self.FLOOR_FRICTION * delta:
        current_motion.y = 0
    else:
        if current_motion.y > 0:
            current_motion.y = current_motion.y - self.FLOOR_FRICTION * delta
        else:
            current_motion.y = current_motion.y + self.FLOOR_FRICTION * delta

    return current_motion

func apply_axis_threshold(axis_value):
    if abs(axis_value) < self.AXIS_THRESHOLD:
        return 0
    return axis_value

func flip(direction):
    if direction == 0:
        return

    var flip_sprite = false
    self.facing = direction
    if direction < 0:
        flip_sprite = true

    self.body.set_flip_h(flip_sprite)

func reset_movement():
    self.movement_vector = [0, 0]

func animate(name):
    self.animations.play(name)

func push_back(enemy, force=2):
    var enemy_position = enemy.get_pos()
    var object_position = self.get_pos()

    var position_delta_x =  object_position.x - enemy_position.x
    var position_delta_y = object_position.y - enemy_position.y

    var scale = force / self.calculate_distance(enemy_position) * 10

    self.avatar.move(Vector2(position_delta_x * scale, position_delta_y * scale))

func stun(duration=null):
    if duration == null:
        duration = self.stun_duration
    self.is_processing = false
    self.is_stunned = true
    self.bag.timers.set_timeout(duration, self, "remove_stun")

func remove_stun():
    self.is_stunned = false
    self.is_processing = true
