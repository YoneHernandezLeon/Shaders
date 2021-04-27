PShader sh;
float time;
boolean flag;

void setup(){
  size(600, 600, P2D);
  noStroke();
  sh = loadShader("shader.glsl");
  time = 0.;
}

void draw(){
  shader(sh);
  sh.set("u_resolution", float(width), float(height));
  sh.set("u_mouse", float(mouseX), float(mouseY));
  sh.set("u_time", millis() / 1000.);
  rect(0, 0, width, height);
  
  if(time > 1.){
    flag = true;
  }
  if(time < 0.){
    flag = false;
  }
  
  if (flag){
    time -= 0.002;
  } else {
    time += 0.002;
  }
}
