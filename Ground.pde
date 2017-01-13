public class Ground {
  PImage groundImg;
  float x;
  float w = 5 * width; 
  float y = 600;


  public void setup() {
    groundImg = loadImage("ground.png");
  }
  public void draw() {
    x -= 10 ;
    w -= 10;
    image(groundImg, x, y, w, 100);
    if ( w <= 3 * width) { 
      w = 5 *  width ;
      x = 0;
    }
  }
}