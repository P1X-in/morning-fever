
var bag

var camera = preload("res://scenes/camera.tscn").instance()
var true_camera_node
var zoom
var locked = false

const CAMERA_FIXED_Y = 132
const SNAP_THRESHOLD = 1

func _init_bag(bag):
    self.bag = bag
    self.true_camera_node = self.camera.get_node('camera')
    self.zoom = self.true_camera_node.get_zoom()

func attach():
    self.bag.board.attach_object(self.camera)
    self.bag.processing.register(self)
    self.set_pos(Vector2(self.bag.positions.CAMERA_POS.x, self.CAMERA_FIXED_Y))
    self.true_camera_node.set_pos(Vector2(0, 0))
    self.true_camera_node.make_current()

func detach():
    self.bag.board.detach_object(self.camera)
    self.bag.processing.remove(self)
    self.unlock()

func get_pos():
    return self.camera.get_pos()

func set_pos(position):
    self.camera.set_pos(position)

func lock():
    self.locked = true
func unlock():
    self.locked = false

func process(delta):
    if self.locked:
        return

    var average_position = Vector2(0, 0)
    var count = 0

    var camera_position = self.camera.get_pos()
    var player_position

    for player in self.bag.players.players:
        if not player.is_playing or not player.is_alive:
            continue
        player_position = player.get_pos()
        average_position = average_position + player_position
        count = count + 1

    if count > 0:
        average_position = average_position / count
        if average_position.x > camera_position.x:
            if average_position.x - camera_position.x > self.SNAP_THRESHOLD:
                average_position.x = camera_position.x + (average_position.x - camera_position.x) * delta * 2
            average_position.y = self.CAMERA_FIXED_Y
            self.camera.set_pos(average_position)