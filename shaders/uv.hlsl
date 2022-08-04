#ifdef GL_ES
precision mediump float;
#endif

varying vec2 vUv;
uniform float offset;


void main() {
	vec2 uv = vUv;
	
	uv -= offset;
	vec4 col = vec4(uv.x,uv.y, 0,1);


	gl_FragColor = col;
}
