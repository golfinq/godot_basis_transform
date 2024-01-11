# Godot Basis Tranformation
## Description
This project showcases transforming between different coordinate systems in the godot game engine in order to perform vector algebra between vectors defined in different coordinate systems. 

## Goal
Rotate a cylinder around a moving axis given two situations:
- The cylinder is able to rotate freely 
- The cylinder is locked to rotate around an additional axis

In actual usage a single object would freely switch between these two situations given a set of conditions. These are showcased side-by-side for independent analysis.

## Defining the transformation using bra-ket notation
The actual math to make this work is pretty simple. We have two vectors/axes in global space that we want to transform into an objects local space. Once we have the vectors/axes defined in the object's local space we can use them to define the axis of rotation (which can only be defined in the local object's space).

This is something which happens all the time in quantum mechanics, and represents a large portion of the math used in the beginning courses of quantum mechanics if starting out with bra-ket notation. Bra-ket notation makes these kinds of transformations really easy to wrangle. I highly recommend <ins>A Modern Approach to Quantum Mechanics</ins> by John S. Townsend for a textbook which takes this approach.

 This can also be justified using a geometric approach, as dot products are projections of one vector along another; but I perfer the explanation here.

### Explanation
In bra-ket notation we have the "ket" $|v\rangle$, which is a vector, and the "bra" $\langle f |$, which is a functional which acts on a vector. Now, these definitions are a bit too broad for what we want to do, since they are defined in *any* abstract vector space that can exist. If we restrict ourselves to just finite-dimensional orthonormal vector spaces, these become just column and row vectors with $\langle f | v \rangle$ becoming the dot (or inner) product and $| v \rangle\langle f |$ becoming the outer product (or a matrix).
```math
|a\rangle = \begin{bmatrix} a_{1} \\ a_{2} \\ \vdots \\ a_{n} \end{bmatrix} \qquad \langle b | = \begin{bmatrix} b_{1} & b_{2} & \cdots & b_{n} \end{bmatrix}
```
However we can still use the power of bra-ket notation to transform vectors between spaces. Specifically, we can define one vector ($|\psi\rangle$) in the space of a different vector space (with basis vectors of $|e_{i}\rangle$) as
```math
|\psi\rangle = \sum_{i=1}^{n} \left(|e_{i}\rangle\langle e_{i} | \right) |\psi\rangle
```

because - as wikipedia puts it - of basic functional analysis. Therefore 
```math
\sum_{i=0}^{n} |e_{i}\rangle\langle e_{i} |
```
is the identity operator (or matrix if using a space where such things make sense). Anyway we are going to plug our vectors into this equation; we want our globaly defined vector $|g\rangle$ defined in our object's space whose basis vectors are $|o_{i}\rangle$. 

```math
\begin{align}
|g\rangle = \sum_{i=1}^{n} \left(|o_{i}\rangle\langle o_{i} | \right) |g\rangle \\
|g\rangle = \sum_{i=1}^{n} | o_{i} \rangle \langle o_{i} | g \rangle \\
\overrightarrow{g'} = \sum_{i=1}^{3} \overrightarrow{o_{i}} \left( \overrightarrow{o_{i}} \cdot \overrightarrow{g} \right) \\
\end{align}
```
### Implementation

This formula can be applied to any vector, which is done in the function `transform_vector_to`. I made the descion to overuse it a bit and show how to apply it to every basis vector in a space. Therefore instead of just one vector, there are now three vectors each transformed individually then packaged back into a single basis object - this is implemented in the function `transform_basis_to`.

## Locking the rotation
In order to lock the rotation I have the object rotate around the locked axis with the speed of rotation defined by the dot product of the locked axis and the "supposed" axis of rotation. If something like what `RigidBody::axis_lock_angular_x` is needed, than something like 
```math
\overrightarrow{r'} = \overrightarrow{r} - \left(\overrightarrow{r} \cdot \hat{x}\right)\hat{x}
```
might work where $\overrightarrow{r}$ is the unlocked rotation axis and $\overrightarrow{r'}$ is the locked rotation axis; but this is untested.
