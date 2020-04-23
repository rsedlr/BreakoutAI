
boolean[] heldKeys = {false, false, false};  // left, right, fire
int fr = 60;
float globalMutationRate = 0.15;  // 0.1
boolean humanPlaying = true;
boolean showBest = false;
boolean saveBest = false;
boolean runBest = false;
boolean paused = false;

Player humanPlayer;


void setup() {
  size(500, 500); 
  frameRate(fr);
  smooth();
  rectMode(CENTER);
  strokeWeight(0);
  humanPlayer = new Player();
}

void draw() {
  if (!paused) {
    background(110);
    if (humanPlaying) {
      if (true) {  // alive
        if (heldKeys[0]) humanPlayer.left(); 
        if (heldKeys[1]) humanPlayer.right();
        if (heldKeys[2]) humanPlayer.fire();
        humanPlayer.ball.move();
        humanPlayer.collisions();        
        humanPlayer.ball.draw();
        humanPlayer.draw();
      } else {
        //humanShip = new Ship();
      }
    }
  } else {
    rect(width/2, 5, width, 5); 
  }
}


void keyPressed() {
  if (key == ' ') paused = !paused;
  if (key == 'b') showBest = !showBest;
  if (key == 's') saveBest = true;
  if (key == '1') fr = 60; frameRate(fr);
  if (key == '2') fr = 120; frameRate(fr);
  if (key == '3') fr = 180; frameRate(fr);
  if (key == '4') fr = 240; frameRate(fr);
  if (key == '5') fr = 300; frameRate(fr);
  if (key == '0') fr = 600; frameRate(fr);
  if (key == '=') globalMutationRate += 0.05;
  if (key == '-') globalMutationRate -= 0.05;
  if (key == CODED) {
    if (keyCode == LEFT) heldKeys[0] = true;
    if (keyCode == RIGHT) heldKeys[1] = true;
    if (keyCode == UP) heldKeys[2] = true;
  }
  //if (!humanPlaying) println("frameRate: "+fr, " showBest: "+showBest, " MR: "+globalMutationRate);
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == LEFT) heldKeys[0] = false;
    if (keyCode == RIGHT) heldKeys[1] = false;
    if (keyCode == UP) heldKeys[2] = false;    
  }
}

boolean lineTouch(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
  float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
  float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
  if (uA >= 0 && uA <= 1 && uB >= 0 && uB <= 1) return true;
  return false;
}

boolean circleTouch() {
 
  return false;
}


//void mousePressed() {
//  println(mouseX + ", " + mouseY);
//}
