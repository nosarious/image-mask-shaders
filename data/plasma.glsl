#define PI 3.1415926535897932384626433832795

uniform vec2      resolution;           // viewport resolution (in pixels)
uniform float     time;           // shader playback time (in seconds)

vec3 shiet;

void main(void  )
{
    vec2 uv = gl_FragCoord.xy / resolution.xy;
    //fragColor = vec4(uv,0.5+0.5*sin(time),1.0);
    uv = uv*2.0-1.0;
    uv.x *= resolution.x / resolution.y;
    uv.y += sin(uv.y*1.5+time);
    //uv.y += sin(uv.y*10.0+time);
    uv.y += sin(uv.x)*cos(uv.x);
    uv.y += sin((uv.y*10.0+time)/2.0);
    uv.x += sin((uv.x+uv.y+time)/2.0);
    uv.x += sin(sqrt(uv.x*uv.x+uv.y*uv.y+1.0)+time);
    
    vec3 shiet = vec3(.5+sin(PI*uv.y),cos(PI*uv.x),abs(sin(time)));
    //vec3 shiet = vec3(sin(PI*uv.y),cos(PI*uv.x),cos(uv.y));
    //vec3 shiet = vec3(sin(PI*uv.x),sin(PI*uv.x+2.0*PI/3.0),sin(PI*uv.x+4.0*PI/3.0));
    //vec3 shiet = vec3(.3*abs(sin(PI*uv.y)),0.9*abs(sin(PI*uv.x)),1.5-abs(cos(PI*uv.y)));
    //fragColor = vec4(uv,0.5+0.5*sin(time),1.0);
    gl_FragColor = vec4(shiet,1.0);
}