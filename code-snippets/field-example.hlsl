// Psuedo Example

// Generate a 2D Distance Field for a 2D sphere (aka. a circle) of a given radius.
float sdSphere(float2 domain, float radius) {
	return length(domain) - radius;
}

// Use smoothstep to sample our field between the surface of the field and just inside it.
// This is a "fixed" sampling method. Other methods use ddx/ddy to get "variable" smoothness depending on view angle/distance.
float sampleSmooth(float field, float smoothing) {
	// I like to use -0.01 when sampling on uvs so that a smoothing value of 1 gives a nice result.
	smoothstep(0., -0.01 * smoothing, field);
} 

// Get the UV of the mesh (In this case, a quad). 
float2 uv; 

// Offset in x and y to "move" our domain. 0.5 will center the domain.
uv -= offset;// 2D Domain

// Run our distance function to get our field.
field = sdSphere(uv, radius); // 2D Field

// Sample our field to get a 2D mask.
return sampleSmooth(field, smoothing); // 2D Mask