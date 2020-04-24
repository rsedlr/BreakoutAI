
class Block {
  float w;
  float h = 25;
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
    float closeX = ball.pos.x;
    float closeY = ball.pos.y;
    int multX = 1; 
    int multY = 1;
    boolean[] ifs = {false, false, false, false};
    if (ball.pos.x < x-w/2) { closeX = x-w/2; multX = -1; ifs[0] = true; }  // check left side 
    if (ball.pos.x > x+w/2) { closeX = x+w/2; multX = -1; ifs[1] = true; }  // check right side
    if (ball.pos.y > y+h/2) { closeY = y+h/2; multY = -1; ifs[2] = true; }  // check bottom side
    if (ball.pos.y < y-h/2) { closeY = y-h/2; multY = -1; ifs[3] = true; }  // check top side
    fill(0);
    //ellipse(closeX, closeY, 10, 10);
    float dis = sqrt(sq(ball.pos.x-closeX) + sq(ball.pos.y-closeY));
    if (dis == 0) {  // if inside block
      println("inside fam");
      if (ball.pos.x - ball.vel.x < x-w/2 || ball.pos.x - ball.vel.x > x+w/2) {
        ball.pos.x = ball.pos.x - ball.vel.x;
        ball.vel.x = ball.vel.x * -1;
      }
      if (ball.pos.y - ball.vel.y < y-h/2 || ball.pos.y - ball.vel.y > y+h/2) {
        ball.pos.y = ball.pos.y - ball.vel.y;
        ball.vel.y = ball.vel.y * -1;
      }
      println("triggered: "  + dis + "  " + multX + "  " + multY + "  Left: " + ifs[0] + "  Right: " + ifs[1] + "  Bottom: " + ifs[2] + "  Top: " + ifs[3]);
      return true;
    } else if (dis < ball.rad) {  // if touching block
      ball.vel.x = ball.vel.x * multX;
      ball.vel.y = ball.vel.y * multY;
      println("triggered: "  + dis + "  " + multX + "  " + multY + "  Left: " + ifs[0] + "  Right: " + ifs[1] + "  Bottom: " + ifs[2] + "  Top: " + ifs[3]);
      return true;
    }
    return false;
  }
  
  boolean hit2(Ball ball) {
    
    return false;
  }
  
}




  //boolean hit2(Ball ball) {
  //  if (ball.pos.x < x + w/2 && ball.pos.x > x - w/2) {  // if ball above or below block
  //    if (ball.pos.y + ball.rad > y - h/2 && ball.pos.y < y || ball.pos.y - ball.rad < y + h/2 && ball.pos.y > y) {
  //      ball.vel.y = ball.vel.y * -1;
  //      return true;
  //    }
  //  } else if (ball.pos.y <= y + h/2 && ball.pos.y >= y - h/2) {  // if ball to left or right of block
  //    if (ball.pos.x + ball.rad > x - w/2 && ball.pos.x < x || ball.pos.x + ball.rad > x - w/2 && ball.pos.x < x) {
  //      ball.vel.x = ball.vel.x * -1;
  //      return true;
  //    }
  //  } 
  //  return false;
  //}
