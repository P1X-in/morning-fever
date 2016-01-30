extends "res://scripts/services/abstract_screen.gd"

var subtitle
var subtitles = ['city patrol', 'strikes again!', 'my local bum', 'recycler rush', 'menel overwatch', 'unimaginable thirst', 'psycho wizard tactics', 'not so self flowing flask', 'this can of yours', 'hobocraft', 'suburban infiltrator']
var is_detached = false

func _init():
    self.screen_scene = preload("res://scenes/branding/title.tscn").instance()
    self.subtitle = self.screen_scene.get_node('center/subtitle')

func _init_bag(bag, container):
    ._init_bag(bag, container)
    randomize()
    self.set_subtitle()

func set_subtitle():
    var number = randi() % self.subtitles.size()
    self.subtitle.set_text(self.subtitles[number])
    if !self.is_detached:
        self.bag.timers.set_timeout(5, self, "set_subtitle")

func attach():
    .attach()
    self.is_detached = false

func detach():
    self.is_detached = true
    .detach()
