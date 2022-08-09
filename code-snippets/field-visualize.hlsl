float3 visualize(float d) {
	// Start with solid blue inside and solid grey outside.
	float3 col = (d>0.0) ? float3(0.25) : float3(0.054,0.450,.819);
	
	// Have brightness falloff from the surface exponentially.
	col *= 1.0 - exp(-6.0*abs(d));

	// Use a fixed smoothstep sampling technique
	// on a modified version of the field to draw concentric rings.
	float m = smoothstep(0.35, 0.45, abs(frac(d * 25.) - 0.5));
	col *= 0.8 + (0.2 * m);

	// Draw a thin white line around the surface.
	col = lerp( col, float3(1.0), 1.0-smoothstep(0.0,0.005,abs(d)) );

	return col;
}