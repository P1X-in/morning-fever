
var bag
var stream_player = StreamPlayer.new()
var sample_player = SamplePlayer.new()

var sound_volume = 0.5
var music_volume = 1.0

var samples = [
    ['attack1', preload('res://scenes/sounds/fx/attack1.wav')],
    ['attack2', preload('res://scenes/sounds/fx/attack2.wav')],
    ['punch1', preload('res://scenes/sounds/fx/punch_1.wav')],
    ['punch2', preload('res://scenes/sounds/fx/punch_2.wav')],
    ['punch3', preload('res://scenes/sounds/fx/punch_3.wav')],
    ['rat_hit', preload('res://scenes/sounds/fx/rat_hit.wav')],
    ['rat_die', preload('res://scenes/sounds/fx/rat_die.wav')],
]

var soundtracks = {
    'stage_2.2' : preload("res://scenes/sounds/soundtrack/stage_2.2.ogg"),
    'street' : preload("res://scenes/sounds/soundtrack/street_stage.ogg"),
    'menu' : preload("res://scenes/sounds/soundtrack/menu_song.ogg")
}

func _init_bag(bag, mount):
    self.bag = bag
    mount.add_child(self.sample_player)
    mount.add_child(self.stream_player)
    self.sample_player.set_sample_library(SampleLibrary.new())
    self.sample_player.set_polyphony(10)

    sample_player.set_default_volume_db(self.sound_volume)
    self.load_samples()

func play(sound):
    sample_player.play(sound)

func play_soundtrack(name):
    self.stop_soundtrack()

    self.stream_player.set_stream(self.soundtracks[name])
    self.stream_player.set_loop(true)
    self.stream_player.play()

func stop_soundtrack():
    self.stream_player.stop()

func load_samples():
    for sample in self.samples:
        self.sample_player.get_sample_library().add_sample(sample[0], sample[1])
