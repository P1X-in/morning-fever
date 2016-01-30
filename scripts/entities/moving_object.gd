extends "res://scripts/entities/destructable_object.gd"

var body
var animations
var velocity
var movement_vector = [0, 0]
var controller_vector = [0, 0]

var AXIS_THRESHOLD = 0.15

var FLOOR_FRICTION = 25
var MOVEMENT_SPEED_CAP = 4

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

    self.avatar.move(current_motion)
    if (self.avatar.is_colliding()):
        var normal = self.avatar.get_collision_normal()
        current_motion = normal.slide(current_motion)
        self.avatar.move(current_motion)
        self.handle_collision(self.avatar.get_collider())
    self.flip(self.controller_vector[0])
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
    if direction < 0:
        flip_sprite = true

    self.body.set_flip_h(flip_sprite)

func reset_movement():
    self.movement_vector = [0, 0]

func push_back(enemy):
    var enemy_position = enemy.get_pos()
    var object_position = self.get_pos()

    var position_delta_x =  object_position.x - enemy_position.x
    var position_delta_y = object_position.y - enemy_position.y
    var force = pow(enemy.attack_strength, -1)

    var scale = force / self.calculate_distance(enemy_position) * 10

    self.avatar.move(Vector2(position_delta_x * scale, position_delta_y * scale))