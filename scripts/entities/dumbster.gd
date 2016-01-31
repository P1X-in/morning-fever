
var bag
var size = 7

func _ready():
    self.bag = self.get_node('/root/game').bag
    self.register()

func register():
    self.bag.items.add(self)

func hit():
    print('got hit')

func reset():
    return
