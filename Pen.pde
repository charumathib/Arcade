public class Pen {
  float y;
  float ySpeed = -5;
  boolean startpos = true;
  float x = width/2;
  PImage penImg;

  public Pen() { 
    penImg = loadImage("picol2-2.png");
  }

  public void makePen() {

    image(penImg, x-7.5, y, 15, 50);
  }

  public void draw() {
    if (startpos) {
      y= height/4*3;
    } else {
      y+=ySpeed;
    }
    makePen();
    keyPressed();
  }

  public void keyPressed() {
    if (key == 's' || key == 'S' ) {
      startpos = false;
    }
  }

  boolean leftBoundary() { //if pen left the top boundary, return true
    return this.y <= 100 ;
  }
}