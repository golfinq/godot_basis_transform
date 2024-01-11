extends CSGCylinder3D

@export var rotate_speed: float = PI/2

func transform_basis_to(a: Basis, b: Basis) -> Basis:
	return Basis(
		a.tdotx(b.x)*b.x + a.tdotx(b.y)*b.y + a.tdotx(b.z)*b.z,
		a.tdoty(b.x)*b.x + a.tdoty(b.y)*b.y + a.tdoty(b.z)*b.z,
		a.tdotz(b.x)*b.x + a.tdotz(b.y)*b.y + a.tdotz(b.z)*b.z,
	)

func transform_vector_to(a: Vector3, b: Basis) -> Vector3:
	return a.dot(b.x)*b.x + a.dot(b.y)*b.y + a.dot(b.z)*b.z

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var lockedbasis: Basis = $"../LockedAxis".basis
	var rotatebasis: Basis = $"../RotateAxis".basis
	var cbasis: Basis = self.basis.orthonormalized()
	
	#var locked_in_local: Basis = transform_basis_to(lockedbasis, cbasis)
	#var rotate_in_local: Basis = transform_basis_to(rotatebasis, cbasis)
	
	#var locked_axis = locked_in_local.y
	#var rotate_axis = rotate_in_local.y
	
	var locked_axis: Vector3 = transform_vector_to(lockedbasis.y, cbasis)
	var rotate_axis: Vector3 = transform_vector_to(rotatebasis.y, cbasis)
	
	self.rotate(locked_axis, abs(rotate_axis.dot(locked_axis))*rotate_speed*delta)
