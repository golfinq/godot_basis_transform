extends CSGCylinder3D

@export var rotate_speed: float = PI/10

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.rotate(self.basis.x, rotate_speed*delta)
