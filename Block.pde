
class Block {
  float w = 25;
  float h = 10;
  float x, y;
  color c; // color(random(255), 255, 255);
  int points;
  
  Block(float newX, float newY, color newC, int newPoints) {
    x = newX;
    y = newY;
    c = newC;
    points = newPoints;
  }
  
  void draw() {
    fill(c);
    rect(x, y, w, h);
  } 
  
  void hit() {
    
  }
  
}
