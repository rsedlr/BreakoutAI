
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
    boolean a = false;
    if (collides(ball.pos.x + ball.vel.x, ball.pos.y, ball.rad)) {
      ball.vel.x *= -1;
      a = true;
    } 
    if (collides(ball.pos.x, ball.pos.y + ball.vel.y, ball.rad)) {
      ball.vel.y *= -1;
      a = true;
    } 
    return a;
  }
  
  boolean collides(float curX, float curY, float rad) {
    float closeX = curX;
    float closeY = curY;
    
    if (curX < x-w/2) closeX = x-w/2;   // check left side 
    else if (curX > x+w/2) closeX = x+w/2;  // check right side
    if (curY > y+h/2) closeY = y+h/2;  // check bottom side
    else if (curY < y-h/2) closeY = y-h/2;  // check top side
    
    float dis = sqrt(sq(curX-closeX) + sq(curY-closeY));
    if (dis < rad) return true;  // if inside block
    return false;
  }
}


  //boolean hit1(Ball ball, int i) {  // old version of hit function
  //  float closeX = ball.pos.x;
  //  float closeY = ball.pos.y;
  //  int multX = 1; 
  //  int multY = 1;
  //  boolean[] ifs = {false, false, false, false};
  //  String s = new String();  // for testing
  //  if (ball.pos.x < x-w/2) { closeX = x-w/2; multX = -1; ifs[0] = true; }  // check left side 
  //  else if (ball.pos.x > x+w/2) { closeX = x+w/2; multX = -1; ifs[1] = true; }  // check right side
  //  if (ball.pos.y > y+h/2) { closeY = y+h/2; multY = -1; ifs[2] = true; }  // check bottom side
  //  else if (ball.pos.y < y-h/2) { closeY = y-h/2; multY = -1; ifs[3] = true; }  // check top side
  //  fill(0);
  //  //ellipse(closeX, closeY, 10, 10);
  //  float dis = sqrt(sq(ball.pos.x-closeX) + sq(ball.pos.y-closeY));
  //  if (dis == 0) {  // if inside block
  //    println("inside: " + i);
  //    float prevX = ball.pos.x - ball.vel.x;
  //    float prevY = ball.pos.y - ball.vel.y;
  //    if (prevX < x-w/2 || prevX > x+w/2) {
  //      ball.pos.x = prevX;
  //      ball.vel.x = ball.vel.x * -1;
  //    }
  //    if (prevY < y-h/2 || prevY > y+h/2) {
  //      ball.pos.y = prevY;
  //      ball.vel.y = ball.vel.y * -1;
  //    }
      
  //    if (ifs[0]) s += " Left";
  //    if (ifs[1]) s += " Right";
  //    if (ifs[2]) s += " Bottom";
  //    if (ifs[3]) s += " Top";
  //    println(dis + "  " + multX + "  " + multY + "    " + s);
  //    return true;
  //  } else if (dis < ball.rad) {  // if touching block
  //    ball.vel.x = ball.vel.x * multX;
  //    ball.vel.y = ball.vel.y * multY;
      
  //    if (ifs[0]) s += " Left";
  //    if (ifs[1]) s += " Right";
  //    if (ifs[2]) s += " Bottom";
  //    if (ifs[3]) s += " Top";
  //    println(dis + "  " + multX + "  " + multY + "    " + s);      return true;
  //  }
  //  return false;
  //}
