attribute vec3 position;
attribute vec2 uv;
attribute vec3 normal;

uniform mat4 projectionMatrix;
uniform mat4 modelViewMatrix;
uniform mat3 normalMatrix;
uniform float time;
uniform vec3 lightPosition;

varying vec2 vUv;

varying vec3 worldNormal, eyeVec, lightVec, vertPos, lightPos;


void main() {

	gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);

	vUv = uv;
	worldNormal = normalMatrix * normal;
}
