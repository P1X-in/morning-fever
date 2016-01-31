
var bag
var size = 7
var body

func _ready():
    self.bag = self.get_node('/root/game').bag
    self.body = self.get_node('body')
    self.register()

func register():
    self.bag.items.add(self)

func hit():
    self.body.set_frame(1)

func reset():
    self.body.set_frame(0)
