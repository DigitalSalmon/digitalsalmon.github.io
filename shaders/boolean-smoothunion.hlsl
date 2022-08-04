#ifdef GL_ES
precision mediump float;
#endif

varying vec2 vUv;
uniform float bool_offset;
uniform float radius;
uniform float offset;
uniform float smoothness;
uniform float bool_smink;

// 2D Box - X|Y
float sdBox(vec2 domain, vec2 size) { 
	vec2 d = abs(domain) - size;
	return min(max(d.x, d.y), 0.0) + length(max(d, 0.0));
}

// 2D Circle
float sdSphere(vec2 domain, float radius) {
	return length(domain) - radius;
}

// 'a' && 'b' smooth. Exponential.
float opSminExp(float a, float b, float k) {
	float res = exp(-k*a) + exp(-k*b);
	return -log(res) / k;
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

vec3 visualize(float d){
	vec3 col = (d>0.0) ? vec3(0.25) : vec3(0.054,0.450,.819);
    col *= 1.0 - exp(-6.0*abs(d));

	float m = smoothstep(0.35, 0.45, abs(fract(d * 25.) - 0.5));

	col *= 0.8 + (0.2 * m);
	col = mix( col, vec3(1.0), 1.0-smoothstep(0.0,0.005,abs(d)) );
	return col;
}

void main() {
	vec2 uv = vUv;
	uv -= 0.5; 
	float a = sdBox(uv - vec2(bool_offset, 0), vec2(0.25));

	float b = sdSphere(uv + vec2(bool_offset, 0), 0.25);
	float field = opSmoothUnion(a,b, bool_smink);

	float mask = smoothstep(0., -0.01 * smoothness, field);

	vec4 col = vec4(1,1,1,1);
	col.rgb *= visualize(field); 

	gl_FragColor = col;
}
