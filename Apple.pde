public class Apple extends Fruit { 

  PImage apple;
  public Apple() { //makes the apple bounce
    xSpeed = 5 ;
    y = (height/2) - 100 ;
    apple = loadImage("picol2.png");
  }


  void makeFruit() { 
    image(apple, x, y, 40, 40);
  }
}