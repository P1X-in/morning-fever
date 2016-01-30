
var bag

var camera = preload("res://scenes/camera.tscn").instance()
var true_camera_node
var zoom

const CAMERA_FIXED_Y = 140

func _init_bag(bag):
    self.bag = bag
    self.true_camera_node = self.camera.get_node('camera')
    self.zoom = self.true_camera_node.get_zoom()

func attach():
    self.bag.board.attach_object(self.camera)
    self.bag.processing.register(self)
    self.set_pos(self.bag.positions.CAMERA_POS)
    self.true_camera_node.set_pos(Vector2(0, 0))
    self.true_camera_node.make_current()

func detach():
    self.bag.board.detach(self.camera)
    self.bag.processing.remove(self)

func get_pos():
    return self.camera.get_pos()

func set_pos(position):
    self.camera.set_pos(position)

func process(delta):
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
        average_position.y = self.CAMERA_FIXED_Y
        if average_position.x > camera_position.x:
            self.camera.set_pos(average_position)