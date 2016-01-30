extends "res://scripts/services/abstract_screen.gd"

var subtitle
var subtitles = ['city patrol', 'strikes again!', 'my local bum', 'recycler rush', 'menel patrol', 'unimaginable thirst', 'psycho wizard tactics', 'not so self flowing flask', 'this can of yours']

func _init():
    self.screen_scene = preload("res://scenes/branding/title.tscn").instance()
    self.subtitle = self.screen_scene.get_node('center/subtitle')
    self.subtitle.set_text(self.generate_subtitle())

func generate_subtitle():
    randomize()
    var number = randi() % self.subtitles.size()
    return self.subtitles[number]
