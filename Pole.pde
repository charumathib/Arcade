public class Pole {
  PImage tube2, tube1;
  float x, y ; 
  boolean pointsComputed = false;
  boolean loadOnce = true;

  public Pole() {
    x = width;
    y = random(250, 600);
  }

  public void draw() {
    if (loadOnce) {
      tube1 = loadImage("tube1.png");
      tube2 = loadImage("tube2.png");
      loadOnce = false;
    }
    image(tube2, x, y, 52, height-y);
    image(tube1, x, 0, 52, y-150);
    x-= 10;
  }

  float tube1_y() { 
    return y - 150 ;
  }


  float thickness() { 
    return 52 ;
  }

  float tube2_y() { 
    return y ;
  }
}