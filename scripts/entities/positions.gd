
const CAMERA_POS = Vector2(180, 140)

var players = [
    Vector2(-100, 20),
    Vector2(-80, 40)
]

func get_random_initial_enemy_position(camera_position):
    var side_offset = 200
    var top_offset = 140
    var belt_width = 80
    var shoulder_width = 40

    var side = randi() % 2
    var height = randi() % belt_width
    var width = randi() % shoulder_width

    side_offset = side_offset + width

    if side == 0:
        side_offset = -side_offset

    return Vector2(camera_position.x + side_offset, top_offset + height)