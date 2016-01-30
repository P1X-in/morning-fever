
var bag

var camera = preload("res://scenes/camera.tscn").instance()

const CAMERA_FIXED_Y = 140

func _init_bag(bag):
    self.bag = bag

func attach():
    self.bag.board.attach_object(self.camera)
    self.bag.processing.register(self)
    self.set_pos(self.bag.positions.CAMERA_POS)

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
        player_position = player.get_pos()
        average_position = average_position + player_position
        count = count + 1

    if count > 0:
        average_position = average_position / count
        average_position.y = self.CAMERA_FIXED_Y
        if average_position.x > camera_position.x:
            self.camera.set_pos(average_position)