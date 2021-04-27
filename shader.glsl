#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359
#define TWO_PI 6.28318530718

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float circle(in vec2 _st, in float _radius){
    vec2 l = _st-vec2(0.5);
    return 1.-smoothstep(_radius-(_radius*0.01),
                         _radius+(_radius*0.01),
                         dot(l,l)*4.0);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution;
    st.x *= u_resolution.x/u_resolution.y;
    vec3 color = vec3(u_mouse.x/u_resolution.x);
    float radius = 0.5;
    float N = 3.;
    
    float scale = 10.;
    
    vec3 colorA = vec3(0.336,0.006,0.395);
    vec3 colorB = vec3(0.000,0.985,0.985);
    
    float off = sin(u_time);
    if ((st.y < 0.5 && st.x > 0.5) || (st.y > 0.5 && st.x < 0.5)){
        if (sign(off)>0.){
      if (floor(mod(st.y*scale, 2.0)) == 1.){
                st.x += off;
            } else {
                st.x -= off;
            } 
        } else {
            if (floor(mod(st.x*scale, 2.0)) == 1.){
                st.y += off;
            } else {
                st.y -= off;
            }
        }
    } else {
        N = 3. + floor((u_mouse.y/u_resolution.y) * 10.);
    }
    
    vec3 gradient = mix(colorA, colorB, (st.x + st.y)/2.);
    
    st = fract(st*scale);
    
    st = st *2.-1.;
    
    
    float a = atan(st.x, st.y) + PI;
    float r = TWO_PI/float(N);
    float d = cos(floor(.5+a/r)*r-a)*length(st);

    vec3 shape = vec3(1.0-smoothstep(.4,.41,d));
    
    color = mix(gradient, color, shape);

    gl_FragColor = vec4(color, 1.0);
}
