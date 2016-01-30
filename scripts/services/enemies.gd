
var bag
var enemies_list = {}

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

