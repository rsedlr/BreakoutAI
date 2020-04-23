
class Brick {
  float wid = 25;
  float hei = 10;
  float x, y;
  color col; // color(random(255), 255, 255);
  
  Brick(float newX, float newY, color newCol) {
    x = newX;
    y = newY;
    col = newCol;
  }
  
  void draw() {
    fill(col);
    rect(x, y, wid, hei);
  } 
  
  void hit() {
    
  }
  
}
