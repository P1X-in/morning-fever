
extends "res://scripts/entities/map.gd"

func _init():
    self.scene = preload("res://scenes/map/city1.tscn").instance()
    self.tilemap = self.scene.get_node('background')
    self.calculate_width()

    self.battles = [
        { 'distance': 250, 'waves': [2, 3, 3] },
        { 'distance': 350, 'waves': [2, 3, 3] },
        { 'distance': 450, 'waves': [3, 4, 4] },
    ]