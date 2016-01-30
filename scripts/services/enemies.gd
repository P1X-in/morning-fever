
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

func find_closest_enemy(object, reach=null, direction=null):
    var enemy
    var closest_enemy = null
    var closest_distance = 9999999
    var enemy_direction
    var calculated_distance

    for enemy_id in self.enemies_list:
        enemy = self.enemies_list[enemy_id]
        if direction != null:
            enemy_direction = enemy.get_pos().x - object.get_pos().x
            if enemy_direction * direction < 0:
                continue

        calculated_distance = enemy.calculate_distance_to_object(object)
        print(calculated_distance)

        if reach != null and calculated_distance > reach:
            continue

        if calculated_distance < closest_distance:
            closest_distance = calculated_distance
            closest_enemy = enemy

    return closest_enemy
