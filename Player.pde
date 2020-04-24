
class Player {
  int score;
  float x, y;
  float w = 46;
  float h = 5;  // 7
  float speed = 7;  // 10
  color c = color(255);
  boolean canFire = true;
  boolean alive = true;
  Ball ball;
  
  ArrayList<Block> blocks = new ArrayList<Block>(); 
  int row = 8;
  int col = 14;
  int[] scores = {7, 5, 3, 1};
  color[] colors = {color(255, 0, 0), color(255, 115, 0), 
                    color(0, 255, 0), color(255, 255, 0)};

  Player() {
    x = width/2;
    y = 480;
    ball = new Ball();
    makeBlocks();
  }
   
  void draw() {
    fill(c);
    rect(x, y, w, h);
    drawBlocks();
    ball.draw();
  }
  
  void move() {
    if (ball.move()) alive = false;
  }
  
  void makeBlocks() {
    float spacingX = width/float(col);
    float spacingY = 25;
    float offset = 10;
    int a = 0;
    for (float j=1; j <= row; j++) {
      for (float i = spacingX/2; i < width; i += spacingX) {
        blocks.add(new Block(i, j*spacingY+offset, colors[a], scores[a]));
      }
      if (j % 2 == 0) a++;  // if j is even, incriment a
    }
    //blocks.add(new Block(400, 400, color(0,0,255), 1));
  }
  
  void drawBlocks() {
    for (int i=0; i < blocks.size(); i++) {
      blocks.get(i).draw(); 
    } 
  }
  
  void collisions() {
    // collisions with paddle
    if (ball.pos.x < x + w/2 && ball.pos.x > x - w/2) {  // if ball above or below paddle
      if (ball.pos.y + ball.rad > y - h/2 && ball.pos.y < y) {  // if ball hit top of paddle
        ball.vel.y = ball.vel.y * -1;  // needs to change angle based on where it hit the paddle
        ball.vel.rotate((ball.pos.x - x)/50);  // rotate based on how far the ball is from centre of paddle
      }
    } 
    
    // collisions with blocks
    for (int i=0; i < blocks.size(); i++) {
      if (blocks.get(i).hit(ball)) {
        score += blocks.get(i).points; 
        blocks.remove(i);
      }
    }
  }
  
  void fire() {
    if (canFire) {
      ball.fire();
      canFire = false;
    }
  }
  
  void left() {
    if (!canFire) {
      if (x - speed > w/2) {
        x -= speed;
      } else if (x > w/2) {
        x = w/2;
      } 
    }
  }
  
  void right() {
    if (!canFire) {
      if (x + speed < width-w/2) {
        x += speed;
      } else if (x < width-w/2) {
        x = width-w/2;
      } 
    }
  }
}

// points: yellow=1, green=3, orange=5, red=7
