
var scene
var tilemap
var battles = []
var width

var TILE_WIDTH = 32

func get_width():
    return self.width

func calculate_width():
    var i = 0
    var cell
    while (true):
        cell = self.tilemap.get_cell(i, 0)
        if cell != -1:
            i = i + 1
        else:
            break

    self.width = i * self.TILE_WIDTH
