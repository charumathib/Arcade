public class Aa extends Score implements Game {
  int level = 1;
  float jitter = 0.02;
  float buffer = 0.06 ;
  float angle = 1.0;
  int z = 590;
  int maxPoles = 10;
  ArrayList<Spoke> spokes = new ArrayList<Spoke>();
  int spokeNumber = 1 ; 
  boolean stop = false ;
  boolean canDraw = true ; 
  boolean gameOver = false;
  color BLACK = #000000;
  color PINK = #FA08DA;
  int alpha = 0, counter = 3;
  boolean setInitialVals = true;
  boolean alreadyCounted = false;
  boolean winScreen = false;


  void setup() { 
    initialSpokes(3);
  }

  public void draw() {
    arcadeScreen.stop();
    if (!gameOver) {
      background(255);
      drawOrbs();
    } else {
      gameOverScreen();
    }
  }


  public void drawOrbs() {
    translate(width/2, height/2);
    makeOrbSpin();
    drawCircle();
    drawSpokes();
    resetMatrix();
    drawLevel();
    decideMaxPoles();
    if (spokes.size() == maxPoles + (level*3)) {//if the player has attatched all the required poles onto the orb, then the level increases
      gameChangeScreen();
    }
  }

  void drawLevel() { 
    textSize(100);
    fill(255);
    text(level, width/2-32, height/2+35);
  }

  void drawCircle() {
    fill(0);
    ellipse(0, 0, 150, 150);
  }

  public void makeOrbSpin() {
    if ( !stop ) { 
      angle += jitter;
      if ( angle >= 2 *PI) { //orb spins
        angle = 0 ;
      }
    }
    rotate(angle);
  }

  void initialSpokes(int numberOfSpokes) { //creates initially present spokes
    float placementAngle = 360/numberOfSpokes ;
    for ( int i = 0; i < numberOfSpokes; i++ ) { 
      spokes.add(new Spoke(BLACK, radians(i * placementAngle), 0));
    }
  }


  void drawSpokes() { 
    for ( Spoke s : spokes ) { 
      s.draw();
      rotate(2*PI - s.angle);
    }
  }



  public void mousePressed() {
    float spokeAngle = 2*PI - angle - buffer ;
    color c ;
    if (!gameOver) {
      if ( spokeCanBeCreated(spokeAngle)) { 
        c = BLACK;
        aaHit.play();
        setScore(level * spokeNumber);
      } else { 
        c = PINK;
        println("PRINTING PINK");
        aaMiss.play();
        gameOver = true;
      }
      if ( spokeNumber <= maxPoles) { //adds spokes to the array list if the spoke can be created
        spokes.add(new Spoke(c, spokeAngle, spokeNumber++));
      }
    }
  }

  public void keyPressed() {//shady business disregard

    if ( key == ENTER ) { 
      stop = true ;
    } else { 
      stop = false ;
    }
  }


  public boolean spokeCanBeCreated(float angle) { //sees if a spoke can be created at a certain point
    float minAngle = angle - radians(7.58);
    float maxAngle = angle + radians(7.58) ;
    for ( Spoke s : spokes ) { 
      if  ( (minAngle <= s.angle) && (s.angle <= maxAngle)) { 
        return false ;
      }
    }
    return true ;
  }

  // Part of the standalone game
  public void gameOverScreen() {
    background(255);
    fill(0);
    textSize(80);
    text("GAME OVER", 125, 100);
    translate(width/2, height/2);
    fill(255);
    ellipse(0, 0, 150, 150);
    makeOrbSpin();
    drawSpokes();
    drawCircle();
  }

  public void decideMaxPoles() {
    fill(0);
    ellipse(width/2, height-90, 25, 25);
    textSize(32);
    fill(0);
    text(maxPoles + " : POLES", width/2-75, height-35);
  }

  public void gameChangeScreen() {
    background(0);
    textSize(32);
    fill(255);
    text("Congratulations you beat \n   level " + level + "... on to level " + int(level+1), 150, height/2-200);
    if (!alreadyCounted) {//the counter restarts every time the game change screen comes up
      counter = 3;
      alreadyCounted = true;
    } 
    if (alpha<=100) {//makes the numbers flash in
      if (level == 5) {
        makeWinningScreen();
      } else {
        alpha ++;
      }
    } else {
      alpha = 0;
      counter--;
      background(0);
    }
    if ( counter > 0) { 
      surface.setTitle("Aa");
      fill(255, alpha);
      textSize(100);
      text(counter, width/2-50, height/2+100);
    } else {//everything is reset before the start of the next level
      level++;
      spokes.clear();
      spokeNumber = 1;
      initialSpokes(level*3);
      setInitialVals = true;
      drawOrbs();
      alreadyCounted = false;
    }
  }

  public void makeWinningScreen() {
    background(0);
    fill(#E81ACD);
    textSize(64);
    text("CONGRATULATIONS \n         YOU WIN", 40, height/2-100);
  }

  boolean gameOver() {
    return gameOver;
  }

  void finalDraw() { 
    stop = true;
    draw();
  }
}