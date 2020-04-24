
class HUD {
  float scorePos = 15;
  
  float x0 = 30;
  float x1 = 260;
  float x2 = 455;
  float x3 = 700;
  
  public void draw(int score, int bestScore) {  // draw method for human player
    fill(0); 
    textSize(32);
    text("Score: " + str(score), scorePos, 550);
    text("Best Score: " + str(bestScore), scorePos, 600);
  }
  
  public void draw(String str1, String str2, String str3, String str4) {  // draw method for AI
    fill(0); 
    textSize(32);
    text(str1, x0, 550);
    text(str2, x1, 550);
    text(str3, x2, 600);
    text(str4, x3, 600);
  }
}
