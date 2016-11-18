#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform sampler2D mask;

uniform vec2 texOffset;
varying vec4 vertColor;
varying vec4 vertTexCoord;

void main() {
  vec4 texColor = texture2D(texture, vertTexCoord.st).rgba;
  //vec4 maskColor = texture2D(mask, vec2(vertTexCoord.s, 1.0 - vertTexCoord.t)).rgba;
    vec4 maskColor = texture2D(mask, verColor.st).rgba;
    if (maskColor.r>0.0){
        gl_FragColor = texColor;//mix(texColor, vec4(0, 0, 0, 0), 1.0 - maskColor.r);
    }
}