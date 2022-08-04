#ifdef GL_ES
precision mediump float;
#endif

varying vec2 vUv;
uniform float offset;
uniform float radius;


void main() {
	vec2 uv = vUv;
	uv -= offset;
	float field = length(uv);
	field -= radius;

	vec4 col = vec4(1,1,1,1);
	col.rgb *= field;

	gl_FragColor = col;
}
