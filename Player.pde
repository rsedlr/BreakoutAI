
class Player {
  int score;
  float x, y;
  float w = 50;
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
  
  // AI stuff
  PVector[] sensors = {new PVector(15, -465), 
                       new PVector(-15, -465),
                       new PVector(100, -465),  
                       new PVector(-100, -465),       
                       new PVector(200, -465), 
                       new PVector(-200, -465), 
                       new PVector(300, -465),  
                       new PVector(-300, -465),  
                       new PVector(400, -465),  
                       new PVector(-400, -465),
                       new PVector(500, -465),
                       new PVector(-500, -465)};  
  NeuralNet brain;
  float fitness = 0;
  boolean replay = false;  // whether the player is being replayed                
  float[] distances = new float[sensors.length] ;  // distances from car sensors
  float[] decision = new float[2]; // the output of the NN


  Player() {
    x = width/2;
    y = 480;
    ball = new Ball();
    makeBlocks();
    //brain = new NeuralNet(sensors.length + 4, 16, 2);  // sensors + ball pos & vel
  }
   
  void draw() {
    fill(c);
    rect(x, y, w, h);
    drawBlocks();
    ball.draw();
    //drawSensors();
  }
  
  void drawSensors() {
    fill(0,0,255);
    stroke(0,0,255);
    strokeWeight(2);
    textSize(15);
    for (int i=0; i < sensors.length; i++) {
      line(x, y, x+sensors[i].x, y+sensors[i].y);
      text(i, x+sensors[i].x, y+sensors[i].y);
    }
    strokeWeight(0);
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
  }
  
  void drawBlocks() {
    for (int i=0; i < blocks.size(); i++) {
      blocks.get(i).draw(); 
    } 
  }
  
  void collisions() {
    // collisions with paddle                    if x in line with paddle and ball hit top of paddle:
    if (ball.pos.x < x + w/2 && ball.pos.x > x - w/2  &&  ball.pos.y + ball.rad > y - h/2 && ball.pos.y < y) {
      ball.vel.y = -abs(ball.vel.y);  // flip the ball's y component of velocity
      if (!ball.touching) ball.vel.rotate((ball.pos.x - x)/50);  // rotate based on how far the ball is from centre of paddle
      ball.touching = true;
    } else {
      ball.touching = false; 
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
  
  // AI stuffs
  void think() {
    decision = brain.output(distances);  // 0.8
    if (decision[0] > 0.8) left();
    if (decision[1] > 0.8) right(); 
  }
  
  void look() {
    //distances = new float[sensors.length];
    float wid = blocks.get(0).w/2;
    float hei = blocks.get(0).h/2;
    float[] dist = new float[4];
    for (int i=0; i < sensors.length; i++) {
      distances[i] = 999;
      for (int j=0; j < blocks.size(); j++) {
        dist[0] = lineDistance(x, y, x+sensors[i].x, y+sensors[i].y, blocks.get(j).x+wid, blocks.get(j).y+hei, blocks.get(j).x+wid, blocks.get(j).y-hei);
        dist[1] = lineDistance(x, y, x+sensors[i].x, y+sensors[i].y, blocks.get(j).x+wid, blocks.get(j).y+hei, blocks.get(j).x-wid, blocks.get(j).y+hei);
        dist[2] = lineDistance(x, y, x+sensors[i].x, y+sensors[i].y, blocks.get(j).x-wid, blocks.get(j).y-hei, blocks.get(j).x+wid, blocks.get(j).y-hei);
        dist[3] = lineDistance(x, y, x+sensors[i].x, y+sensors[i].y, blocks.get(j).x-wid, blocks.get(j).y-hei, blocks.get(j).x-wid, blocks.get(j).y+hei);
        //line(blocks.get(j).x+wid, blocks.get(j).y+hei, blocks.get(j).x+wid, blocks.get(j).y-hei);
        //line(blocks.get(j).x+wid, blocks.get(j).y+hei, blocks.get(j).x-wid, blocks.get(j).y+hei);
        //line(blocks.get(j).x-wid, blocks.get(j).y-hei, blocks.get(j).x+wid, blocks.get(j).y-hei);
        //line(blocks.get(j).x-wid, blocks.get(j).y-hei, blocks.get(j).x-wid, blocks.get(j).y+hei);
        for (int a=0; a < dist.length; a++) {
          if (dist[a] < distances[i] && dist[a] != 0) distances[i] = dist[a];
        }
      }
    }
    //println("********************");
    //println(distances);
  }
  
  float lineDistance(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
    float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) {
      //float intersectionX = x1 + (uA * (x2-x1));
      //float intersectionY = y1 + (uA * (y2-y1));
      //fill(0);
      //ellipse(intersectionX, intersectionY, 7, 7);
      return sqrt(sq((uA * (x2-x1))) + sq((uA * (y2-y1))));  // return distance
    }
    return 0;
  }
}

// points: yellow=1, green=3, orange=5, red=7
