extends CSGCylinder3D

@export var rotate_speed: float = PI/2

func transform_basis_to(a: Basis, b: Basis) -> Basis:
	return Basis(
		a.tdotx(b.x)*b.x + a.tdotx(b.y)*b.y + a.tdotx(b.z)*b.z,
		a.tdoty(b.x)*b.x + a.tdoty(b.y)*b.y + a.tdoty(b.z)*b.z,
		a.tdotz(b.x)*b.x + a.tdotz(b.y)*b.y + a.tdotz(b.z)*b.z,
	)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var lockedbasis: Basis = $"../LockedAxis".basis
	var rotatebasis: Basis = $"../RotateAxis".basis
	var cbasis: Basis = self.basis.orthonormalized()
	
	var locked_in_local: Basis = transform_basis_to(lockedbasis, cbasis)
	var rotate_in_local: Basis = transform_basis_to(rotatebasis, cbasis)
	
	var locked_axis = locked_in_local.y
	var rotate_axis = rotate_in_local.y
	
	self.rotate(rotate_axis, rotate_speed*delta)
