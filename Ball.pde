
class Ball {
  float diam = 10;
  float rad = diam/2;
  float speed = 4;  // 5
  color col = color(255);
  PVector pos;
  PVector vel = new PVector();
  boolean touching = false;
  
  Ball() {
     pos = new PVector(width/2, 470);  // 460
  }
  
  void draw() {
    fill(col);
    ellipse(pos.x, pos.y, diam, diam); 
  }
  
  boolean move() {
    if (pos.x-rad < 0 || pos.x+rad > width) {
       vel.x = -vel.x;
    }
    if (pos.y-rad < 0) {
       vel.y = -vel.y;
    }
    if (pos.y+rad > 500) return true;  // if gone past paddle, end game
    pos.add(vel); 
    return false;
  }
  
  void fire() {
    vel = PVector.fromAngle(random(4.14, 5.28));  // PI+1, TWO_PI-1
    //vel = PVector.fromAngle(-PI/4);  // straight up
    vel.mult(speed); 
  }
}
