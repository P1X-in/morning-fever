
var bag
var enemies_list = {}

var templates = {
    'bum' : preload('res://scripts/entities/bum.gd')
}

func _init_bag(bag):
    self.bag = bag

func reset():
    for enemy in self.enemies_list:
        self.enemies_list[enemy].despawn()
    self.enemies_list.clear()

func add_enemy(enemy):
    self.enemies_list[enemy.get_instance_ID()] = enemy

func del_enemy(enemy):
    self.enemies_list.erase(enemy.get_instance_ID())

func spawn(name, position):
    var new_enemy = self.templates[name].new(self.bag)
    self.add_enemy(new_enemy)
    new_enemy.spawn(position)
