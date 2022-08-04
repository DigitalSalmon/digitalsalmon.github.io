#ifdef GL_ES
precision mediump float;
#endif

varying vec2 vUv;
uniform float radius;
uniform float offset;
uniform float smoothness;


void main() {
	vec2 uv = vUv;
	uv -= offset;
	float field = length(uv);
	field -= radius;

	float mask = smoothstep(0., -0.01 * smoothness, field);

	vec4 col = vec4(1,1,1,1);
	col.rgb *= mask;

	gl_FragColor = col;
}
