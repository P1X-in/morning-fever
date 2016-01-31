
var bag

var items = {}
var pickups = {}

var bottle = preload("res://scripts/entities/bottle.gd")

func _init_bag(bag):
    self.bag = bag

func reset():
    for item in self.items:
        self.items[item].reset()

    for pickup_id in self.pickups:
        self.pickups[pickup_id].despawn()
    self.pickups.clear()

func spawn_bottle(position):
    var new_bottle = self.bottle.new(self.bag)
    new_bottle.spawn(position)
    self.pickups[new_bottle.get_instance_ID()] = new_bottle

func despawn_bottle(bottle):
    self.pickups.erase(bottle.get_instance_ID())
    bottle.despawn()

func add(item):
    self.items[item.get_instance_ID()] = item

func del(item):
    self.items.erase(item.get_instance_ID())

func find_items_in_range(player, reach, direction=null):
    var item
    var item_direction
    var calculated_distance
    var found = []

    for item_id in self.items:
        item = self.items[item_id]
        if direction != null:
            item_direction = item.get_pos().x - player.get_pos().x
            if item_direction * direction < 0:
                continue

        calculated_distance = player.calculate_distance_to_object(item)

        if calculated_distance > reach + item.size:
            continue

        found.append(item)

    return found

func find_pickups_in_range(player, reach, direction=null):
    var pickup
    var pickup_direction
    var calculated_distance
    var found = []

    for pickup_id in self.pickups:
        pickup = self.pickups[pickup_id]
        if direction != null:
            pickup_direction = pickup.get_pos().x - player.get_pos().x
            if pickup_direction * direction < 0:
                continue

        calculated_distance = player.calculate_distance_to_object(pickup)
        print(calculated_distance)
        if calculated_distance > reach:
            continue

        found.append(pickup)

    return found