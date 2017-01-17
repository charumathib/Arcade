public class FlappyBird extends Score implements Game {

  PImage backPic, birdImg, groundImg;
  Bird birds;
  Ground ground ;
  ArrayList<Pole> poles = new ArrayList<Pole>();
  int start, now ; 
  boolean gameOver = false ;
  int points;
  int highscore;
  Pole p = new Pole();


  public void setup() {
    arcadeScreen.stop();
    birds = new Bird();
    ground = new Ground();
    backPic = loadImage("skyline2.jpg");
    birds.setup();
    ground.setup();
  }

  public void draw() {
    image(backPic, 0, 0, width, height);
    generatePoles();
    birds.draw();
    ground.draw();
    addPoints1();
    displayPoints();
    isGameOver();
    if (isGameOver()) {
      flappyDeath.play();
    }
  }

  void addPoints1() {
    for ( Pole pole : poles ) {
      if ( birds.x+ birds.thickness() >= pole.x && // if the bird is in between the top and bottom poles
        birds.x+ birds.thickness() <=pole.x+pole.thickness() && // if the bird has not left the two poles
        !pole.pointsComputed && // if points for that pole have not already been computed
        birds.y<=pole.tube2_y() && //if bird is higher than bottom pole
        birds.y>= pole.tube1_y()) { //if bird is lower than top pole

        points++;
        incrementScore(1);
        flappyPoints.play();
        pole.pointsComputed = true;
      }
    }
  }


  boolean isGameOver() { 
    gameOver = birdHitsObstacle() || birdHitsFloor() ;
    return gameOver;
  }

  boolean birdHitsObstacle() { 

    boolean hit = false ; 
    for ( Pole pole : poles ) { 
      hit =  
        ( (birds.x >= pole.x && birds.x <= pole.x + pole.thickness()) // bird is found within both poles
        && ( birds.y >= pole.tube2_y() || birds.y <= pole.tube1_y())); // bird hits any pole
      if ( hit ) { 
        return hit ;
      }
    }
    return hit ;
  }


  boolean birdHitsFloor() { 

    return birds.y>= ground.y ;
  }


  public void mousePressed() {
    birds.mousePressed();
  }

  public void generatePoles() {
    if (secondsElapsed(2)) {
      poles.add(new Pole());
      start = now ;
    }
    clearUnusedPoles();
    drawPoles();
  }

  boolean secondsElapsed(float seconds) { 
    now = millis();
    float duration = (now - start)/1000 ; 
    return duration >= seconds ;
  }

  void clearUnusedPoles() { 
    ArrayList<Pole> removeList = new ArrayList<Pole>();
    for ( Pole p : poles) { 
      if ( p.x <= -52) { 
        removeList.add(p);
      }
    }
    for ( Pole p : removeList ) { 
      poles.remove(p);
    }
  }

  void drawPoles() { 
    for ( Pole p : poles) {
      p.draw();
    }
  }  



  void displayPoints() {
    textSize(64);
    fill(255);
    text(points, width/2-25, 100);
  }

  void keyPressed() {
  }

  boolean gameOver() {
    return gameOver;
  }
}