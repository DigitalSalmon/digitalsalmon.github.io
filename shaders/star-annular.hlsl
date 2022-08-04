#ifdef GL_ES
precision mediump float;
#endif

varying vec2 vUv;
uniform float offset;
uniform float radius;
uniform float annular_thickness;
uniform float shape_size;
uniform float secondary_size;

vec3 visualize(float d){
	vec3 col = (d>0.0) ? vec3(0.25) : vec3(0.054,0.450,.819);
    col *= 1.0 - exp(-6.0*abs(d));

	float m = smoothstep(0.35, 0.45, abs(fract(d * 25.) - 0.5));

	col *= 0.8 + (0.2 * m);
	col = mix( col, vec3(1.0), 1.0-smoothstep(0.0,0.005,abs(d)) );
	return col;
}

float sdStar5(in vec2 p, in float r, in float rf)
{
    const vec2 k1 = vec2(0.809016994375, -0.587785252292);
    const vec2 k2 = vec2(-k1.x,k1.y);
    p.x = abs(p.x);
    p -= 2.0*max(dot(k1,p),0.0)*k1;
    p -= 2.0*max(dot(k2,p),0.0)*k2;
    p.x = abs(p.x);
    p.y -= r;
    vec2 ba = rf*vec2(-k1.y,k1.x) - vec2(0,1);
    float h = clamp( dot(p,ba)/dot(ba,ba), 0.0, r );
    return length(p-ba*h) * sign(p.y*ba.x-p.x*ba.y);
}


void main() {
	vec2 uv = vUv;
	uv -= 0.5;
	float field = sdStar5(uv, (0.4 * secondary_size), 0.5 * shape_size);

	field = abs(field) - annular_thickness;


	vec4 col = vec4(1,1,1,1);
	col.rgb *= visualize(field);

	gl_FragColor = col;
}
