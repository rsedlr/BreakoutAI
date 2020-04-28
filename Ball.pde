
class Ball {
  float diam = 10;
  float rad = diam/2;
  //float speed = 5;  // 4 for human, 5 for AI
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
    float angle;
    if (humanPlaying) angle = random(3.94, 5.48);  // PI+0.8, TWO_PI-0.8
    else angle = -1.57-0.2;
    vel = PVector.fromAngle(angle);  
    vel = PVector.fromAngle(-1.57+1.15);  // straight up
    vel.mult(ballSpeed); 
  }
}
