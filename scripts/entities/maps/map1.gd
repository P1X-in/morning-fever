
extends "res://scripts/entities/map.gd"

func _init():
    self.scene = preload("res://scenes/map/city1.tscn").instance()
    self.tilemap = self.scene.get_node('background')
    self.calculate_width()
    self.time_limit = 999

    self.battles = [
        { 'distance': 250, 'waves': [2, 3, 3] },
        { 'distance': 350, 'waves': [2, 3, 3] },
        { 'distance': 450, 'waves': [3, 4, 4] },
        { 'distance': 550, 'waves': [4, 5, 5] },
        { 'distance': 650, 'waves': [4, 5, 5] },
        { 'distance': 850, 'waves': [5, 5, 6] },
        { 'distance': 1050, 'waves': [6, 3, 5] },
        { 'distance': 1350, 'waves': [5, 3, 5 , 4] },
        { 'distance': 1550, 'waves': [6, 6 ,7] },
        { 'distance': 1950, 'waves': [4, 5, 6, 7, 8, 10] }
    ]