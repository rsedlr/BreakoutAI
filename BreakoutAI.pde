// TODO: add lives. 

boolean[] heldKeys = {false, false, false};  // left, right, fire
int fr = 60;
float globalMutationRate = 0.15;  // 0.1
boolean humanPlaying = true;
boolean showBest = false;
boolean saveBest = false;
boolean runBest = false;
boolean paused = false;
int bestScore;
float bestFitness = 0;
float ballSpeed;
int alive;

Player humanPlayer;
Population pop;
HUD hud;

void setup() {
  size(500, 700); 
  frameRate(fr);
  //smooth();
  rectMode(CENTER);
  strokeWeight(0);
  hud = new HUD();
  if (humanPlaying) {
    ballSpeed = 4.5;
    humanPlayer = new Player(); 
  } else {
    ballSpeed = 4.5;  // 5
    pop = new Population(200); 
  }
}

void draw() {
  if (!paused) {
    background(110);
    rect(width/2, 500, width, 2);
    if (humanPlaying) {
      if (humanPlayer.alive) {
        if (heldKeys[0]) humanPlayer.left(); 
        if (heldKeys[1]) humanPlayer.right();
        if (heldKeys[2]) humanPlayer.fire();
        humanPlayer.move();
        humanPlayer.collisions();        
        humanPlayer.draw();
        hud.draw(humanPlayer.score, bestScore);
        //humanPlayer.look();
      } else {
        if (humanPlayer.score > bestScore) bestScore = humanPlayer.score;
        humanPlayer = new Player();
        println();
      }
    } else if (runBest) {  

    } else {  // if just evolving normally
      if (!pop.done()) {  //if any players are alive then update them
        hud.draw("Gen: "+str(pop.gen), "Alive: "+str(alive), "Best score: "+str(bestScore), "Prev Fitness: "+str(bestFitness));
        pop.updateAlive();
      } else {  //all dead, do genetic algorithm shit
        pop.calculateFitness(); 
        pop.naturalSelection();
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
  if (!humanPlaying) println("frameRate: "+fr, " showBest: "+showBest, " MR: "+globalMutationRate);
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


//void mousePressed() {
//  println(mouseX + ", " + mouseY);
//}
