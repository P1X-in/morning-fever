var root

var helpers = preload("res://scripts/services/helpers.gd").new()
var file_handler = preload('res://scripts/services/file_handler.gd').new()
var processing = preload('res://scripts/services/processing.gd').new()
var timers = preload('res://scripts/services/timers.gd').new()
var input = preload("res://scripts/input/input.gd").new()
var intro = preload("res://scripts/services/intro.gd").new()
var board = preload("res://scripts/services/board.gd").new()
var sound = preload("res://scripts/controllers/sound_controller.gd").new()

func _init(root_node):
    self.root = root_node
    self.processing._init_bag(self, root_node)
    self.timers._init_bag(self, root_node)
    self.input._init_bag(self)
    self.intro._init_bag(self, root_node.mount)
    self.board._init_bag(self, root_node.mount)
    self.sound._init_bag(self, root_node)
