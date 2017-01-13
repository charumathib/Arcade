public class Pineapple extends Fruit { 
  PImage pineapple;

  public Pineapple() { //makes pineapple bounce
    xSpeed = -8 ;
    y = (height/2) - 200;
    pineapple = loadImage("picol2-1.png");
  }

  void makeFruit() { 

    image(pineapple, x, y, 40, 70);
  }
}