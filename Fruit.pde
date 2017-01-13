public abstract class Fruit {
  int xSpeed, ySpeed;
  int x, y;
  boolean startpos = true;
  public Fruit() {
  }

  void draw() {
    if (startpos) {
      x = width/2-20;
    } else {
      x+=xSpeed;
      if (x >= width-20 || x <= 20) {//boundary conditions
        xSpeed = -xSpeed;
      }
    }

    makeFruit();
    keyPressed();
  }

  void makeFruit() {//draws the specific fruit
  }

  void keyPressed() {//makes fruits move when tab is pressed
    if (key == TAB) {
      startpos = false;
    }
  }
}