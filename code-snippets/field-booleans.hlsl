float2 opUnion(float a, float b) { 
	return min(a,b);
}

float opSubtraction(float a, float b) {
	return max(-b, a);
}

float opIntersect(float a, float b) {
	return max(a, b);
}

float opExclusion(float a, float b) {
	return opUnion(opSubtraction(a,b), opSubtraction(b,a));
}

float opSmoothUnion(float d1, float d2, float k) {
    float h = clamp( 0.5 + 0.5*(d2-d1)/k, 0.0, 1.0 );
    return mix( d2, d1, h ) - k*h*(1.0-h); 
}

float opSmoothSubtraction(float d1, float d2, float k) {
    float h = clamp( 0.5 - 0.5*(d2+d1)/k, 0.0, 1.0 );
    return mix( d2, -d1, h ) + k*h*(1.0-h); 
}

float opSmoothIntersection(float d1, float d2, float k) {
    float h = clamp( 0.5 - 0.5*(d2-d1)/k, 0.0, 1.0 );
    return mix( d2, d1, h ) + k*h*(1.0-h); 
}