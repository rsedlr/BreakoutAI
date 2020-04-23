
class Ball {
  float diam = 8;
  float rad = diam/2;
  color col = color(255);
  PVector pos;
  PVector vel = new PVector();
  
  Ball() {
     pos = new PVector(width/2, 460);
  }
  
  void draw() {
    fill(col);
    ellipse(pos.x, pos.y, diam, diam); 
  }
  
  void move() {
    if (pos.x-rad < 0 || pos.x+rad > width) {
       vel.x = -vel.x;
    }
    if (pos.y-rad < 0 || pos.y+rad > height) {
       vel.y = -vel.y;
    }
    if (pos.y+rad > height) println("life lost");
    pos.add(vel); 
  }
}
