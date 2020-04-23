
class Player {
  int score;
  float x, y;
  float w = 40;
  float h = 5;  // 7
  float speed = 7;  // 10
  color c = color(255);
  boolean canFire = true;
  Ball ball;
  
  // blocks stuff
  ArrayList<Block> blocks = new ArrayList<Block>(); 
  int row = 8;
  int col = 14;
  int[] scores = {7, 5, 3, 1};
  color[] colors = {color(255, 0, 0), color(255, 115, 0), 
                    color(0, 255, 0), color(255, 255, 0)};

  Player() {
    x = width/2;
    y = 470;
    ball = new Ball();
    makeBlocks();
  }
   
  void draw() {
    fill(c);
    rect(x, y, w, h);
    drawBlocks();
  }
  
  void makeBlocks() {
    float spacingX = (width)/float(col);
    float spacingY = 30;
    int a = 0;
    for (float j=1; j <= row; j++) {
      for (float i = spacingX/2; i < width; i += spacingX) {
        blocks.add(new Block(i, j*spacingY, colors[a], scores[a]));
      }    
      if (j % 2 == 0) a++;  // if j is even, incriment a
    } 
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
        ball.vel.y = ball.vel.y * -1;
      }
    } 
    // collisions with blocks
    for (int i=0; i < blocks.size(); i++) {
      if (blocks.get(i).hit(ball)) {
        score += blocks.get(i).points; 
        println(blocks.get(i).points, score);
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
