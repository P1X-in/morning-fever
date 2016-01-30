
extends AnimationPlayer

# member variables here, example:
# var a=2
# var b="textvar"

func smoke():
	self.play("smoking")
	return

func _ready():
	self.connect("finished", self, 'smoke') 
	pass


