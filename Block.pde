
class Block {
  float w;
  float h = 10;
  float x, y;
  color c; // color(random(255), 255, 255);
  int points;
  
  Block(float newX, float newY, color newC, int newPoints) {
    w = width/14;
    x = newX;
    y = newY;
    c = newC;
    points = newPoints;
  }
  
  void draw() {
    fill(c);
    rect(x, y, w, h);
  } 
  
  boolean hit(Ball ball) {
    if (ball.pos.x < x + w/2 && ball.pos.x > x - w/2) {  // if ball above or below block
      if (ball.pos.y + ball.rad > y - h/2 && ball.pos.y < y || ball.pos.y - ball.rad < y + h/2 && ball.pos.y > y) {
        ball.vel.y = ball.vel.y * -1;
        return true;
      }
    } else if (ball.pos.y < y + h/2 && ball.pos.y > y - h/2) {
      if (ball.pos.x + ball.rad > x - w/2 && ball.pos.x < x || ball.pos.x + ball.rad > x - w/2 && ball.pos.x < x) {
        ball.vel.x = ball.vel.x * -1;
        return true;
      }
    }
    return false;
  }
  
}
