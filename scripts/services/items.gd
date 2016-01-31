
var bag

var items = {}
var pickups = {}

func _init_bag(bag):
    self.bag = bag

func reset():
    for item in self.items:
        self.items[item].reset()

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