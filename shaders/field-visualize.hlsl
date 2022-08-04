#ifdef GL_ES
precision mediump float;
#endif

varying vec2 vUv;
uniform float offset;
uniform float radius;

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
	uv -= offset;
	float field = length(uv);
	field -= radius;

	vec4 col = vec4(1,1,1,1);
	col.rgb *= visualize(field);

	gl_FragColor = col;
}
