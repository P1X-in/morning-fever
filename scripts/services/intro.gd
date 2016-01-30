
var bag
var container

var intro_scene = preload("res://assets/branding/title.tscn").instance()

func _init_bag(bag, container):
    self.bag = bag
    self.container = container

func attach():
    if self.container.is_a_parent_of(self.intro_scene):
        return

    self.container.add_child(self.intro_scene)

func detach():
    if !self.container.is_a_parent_of(self.intro_scene):
        return

    self.container.remove_child(self.intro_scene)