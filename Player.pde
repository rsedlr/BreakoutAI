
class Player {
  int score;
  float x, y;
  float wid = 40;
  float hei = 7;
  float hWid = wid/2;
  float speed = 10;
  float ballSpeed = 10;  // 12
  color col = color(255);
  boolean canFire = true;
  Ball ball;
  
  
  Player() {
     x = width/2;
     y = 470;
     ball = new Ball();
  }
  
  void draw() {
    fill(col);
    rect(x, y, wid, hei);
  }
  
  void fire() {
    if (canFire) {
      println("fireeee");
      ball.vel = PVector.fromAngle(random(3.84, 5.58));  // PI, TWO_PI
      ball.vel.mult(ballSpeed);
      canFire = false;
    }
  }
  
  void left() {
    if (!canFire) {
      if (x - speed > 0) {
        x -= speed;
      } else if (x > 0) {
        x = hWid;
      } 
    }
  }
  
  void right() {
    if (!canFire) {
      if (x + speed < width-hWid) {
        x += speed;
      } else if (y < width-hWid) {
        x = width-hWid;
      } 
    }
  }
}
