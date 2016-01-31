
var bag
var size = 7
var body
var bottle_position = Vector2(15, 15)
var open = false

func _ready():
    self.bag = self.get_node('/root/game').bag
    self.body = self.get_node('body')
    self.register()

func register():
    self.bag.items.add(self)

func hit():
    self.bag.sound.play('con_hit')
    if self.open:
        return

    self.body.set_frame(1)
    self.bag.items.spawn_bottle(self.get_pos() + self.bottle_position)
    self.bag.enemies.spawn_dumpster_rats(2, self.get_pos())
    self.bag.sound.play('rat_hit')
    self.open = true


func reset():
    self.body.set_frame(0)
    self.open = false
