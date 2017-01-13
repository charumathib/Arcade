public class Bird {
  PImage birdImg;
  int y = height/2;
  int x = width/2-100;
  public Bird() {
  }

  public void setup() {
    birdImg = loadImage("bird_sing.png");
  }
  public void draw() {
    image(birdImg, x, y, 36, 26);
    if (!mousePressed) {
      y+=10;
    }
  }
  public void mousePressed() {
    y-=60;
  }

  float thickness() { 
    return 36 ;
  }
}