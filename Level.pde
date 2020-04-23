
class Level {
  ArrayList<Brick> bricks = new ArrayList<Brick>(); 
  int row = 8;
  int col = 14;
  color[] rowCol = new color[row];
  
  Level() {
    for (int i=0; i < row; i++) {
      rowCol[i] = color(i*32, 255, 255);  // 32 = 255/8
    }  
    
    float spacingX = (width)/float(col);
    float spacingY = (height/2)/row;
    println(spacingX);
    int a = 0;
    for (float j = spacingY; j < height/2; j += spacingY) {
      for (float i = spacingX/2; i < width; i += spacingX) {
        bricks.add(new Brick(i, j, rowCol[a]));
      }    
      a++;
    }
  }
  
  void draw() {
    for (int i=0; i < bricks.size(); i++) {
      bricks.get(i).draw(); 
    }
  }
}
