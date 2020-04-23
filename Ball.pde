
class Ball {
  float diam = 8;
  float rad = diam/2;
  float speed = 5;  // 10
  color col = color(255);
  PVector pos;
  PVector vel = new PVector();
  
  Ball() {
     pos = new PVector(width/2, 460);  // 460
  }
  
  void draw() {
    fill(col);
    ellipse(pos.x, pos.y, diam, diam); 
  }
  
  void move() {
    if (pos.x-rad < 0 || pos.x+rad > width) {
       vel.x = -vel.x;
    }
    if (pos.y-rad < 0) {
       vel.y = -vel.y;
    }
    //if (pos.y+rad > height) vel.y = -vel.y; println("life lost");
    pos.add(vel); 
  }
  
  void fire() {
    vel = PVector.fromAngle(random(3.84, 5.58));  // PI+0.7, TWO_PI-0.7
    //vel = PVector.fromAngle(3.84);
    vel.mult(speed); 
  }
}
