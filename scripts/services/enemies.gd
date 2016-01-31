
var bag
var enemies_list = {}

var types = {
    'bums' : ['bum1', 'homeless'],
    'rats' : ['rat1', 'rat2', 'rat3']
}
var templates = {
    'bum1' : preload('res://scripts/entities/bum.gd'),
    'homeless' : preload('res://scripts/entities/homeless.gd'),
    'rat1' : preload('res://scripts/entities/rat.gd'),
    'rat2' : preload('res://scripts/entities/rat2.gd'),
    'rat3' : preload('res://scripts/entities/rat3.gd')
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

func no_enemies():
    if self.enemies_list.size() == 0:
        return true
    return false

func spawn(name, position):
    var new_enemy = self.templates[name].new(self.bag)
    self.add_enemy(new_enemy)
    new_enemy.spawn(position)

func spawn_dumpster_rats(size, dumpster_position):
    var position
    randomize()
    var units = self.types['rats']
    var count = units.size()

    for i in range(size):
        position = self.bag.positions.get_random_initial_enemy_position(dumpster_position, 'near')
        self.spawn(units[randi() % count], position)

func spawn_wave(size, wave_type='bums'):
    var position
    randomize()
    var units = self.types[wave_type]
    var count = units.size()

    for i in range(size):
        position = self.bag.positions.get_random_initial_enemy_position(self.bag.camera.get_pos())
        self.spawn(units[randi() % count], position)

func find_enemies_in_range(object, reach, direction=null):
    var enemy
    var enemy_direction
    var calculated_distance
    var found = []

    for enemy_id in self.enemies_list:
        enemy = self.enemies_list[enemy_id]
        if direction != null:
            enemy_direction = enemy.get_pos().x - object.get_pos().x
            if enemy_direction * direction < 0:
                continue

        calculated_distance = enemy.calculate_distance_to_object(object)

        if calculated_distance > reach:
            continue

        found.append(enemy)

    return found

func stop_processing():
    for enemy in enemies_list:
        self.enemies_list[enemy].is_processing = false
