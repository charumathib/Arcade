public class PPAP implements Game { 
  Pen pen;
  Fruit a, pine, pear;
  boolean gameBegun, showCounters;
  PFont font;
  float alpha = 0;
  int counter = 3 ;
  int score = 0;
  int lives = 3;
  int highScore = 0;
  int ySpeed = -5;
  boolean aMove, pMove;
  PImage pineBreak, appleBreak, life ;
  float i, k, l, j;
  boolean startpos = true;
  boolean startpos2 = true;
  boolean gameOver = false;

  public void setup() {
    pen = new Pen();//creates all objects
    a = new Apple();
    pine = new Pineapple();
    appleBreak = loadImage("picol2-4.png");
    pineBreak = loadImage("picol2-3.png");
    life = loadImage("url.png");

    font  = loadFont("ArialRoundedMTBold-48.vlw");//loads and sets font
    textFont(font);
    noStroke();
  }
  public void draw() {
    background(#FFC503);
    if ( gameBegun) {//if the game has begun, display game play screen
      gamePlay();
      if ( aMove) { 
        appleBreaks();
      }
      if (pMove) {
        pineappleBreaks();
      }
    } else if (showCounters) { //
      numbersComeUp();
    } else { 
      gameStartScreen();//beginning screen
    }
  }

  public void keyPressed() {
    if (key == ENTER && !showCounters) {//if the enter button was pressed, make the numbers come up
      showCounters = true;
    }
  }

  public void gamePlay() {
    shapesAreDrawn();
    setScore();
  }

  public void numbersComeUp() {
    if (alpha<=100) {//makes the numbers flash in
      alpha ++;
    } else {
      alpha = 0;
      counter--;
      background(#FFC503);
    }
    if ( counter > 0) { 
      surface.setTitle("Pen Pineapple Apple Pen");
      fill(0, alpha);
      textSize(200);
      text(counter, width/2-75, height/2);
    } else { 
      gameBegun = true ;
    }
  }

  public void gameStartScreen() {//creates the game start screen
    background(#FFC503);
    fill(#FF2403);
    textSize(50);
    text("Pen Pineapple Apple Pen", width/16, 100, 100);
    fill(#FF8E03);
    text("Pen Pineapple Apple Pen", width/16+5, 100, 100);
    textSize(30);
    fill(0);
    text("PRESS ENTER TO BEGIN", 175, 250);
  }

  public void shapesAreDrawn() {//makes different fruits come up at each score interval
    if (score <=10) {
      pen.draw();
      a.draw();
    } else if (score >10 ) {
      pen.draw();
      a.draw();
      pine.draw();
    }
  }

  public void setScore() {
    if ( hit(pen, a)  ) {//if the pen hit the apple, score incremented by one and pen reset
      startpos = true;
      aMove = true ; 
      score+=1;
      resetPen();
    } else if (hit(pen, pine)) {// if pen hit pear score incremented by 9 and score reset
      startpos2 = true;
      pMove = true ; 
      score+=3;
      resetPen();
    } else if ( pen.leftBoundary()) {//if the ben left the boundary, the number of lives decreases and pen is reset
      lives--;
      resetPen();
    }
    if (lives == 1) {//draw one life 
      oneLife();
    }
    if (lives == 2) {//draw two lives
      twoLives();
      oneLife();
    }
    if (lives == 3) {//draw three lives
      threeLives();
      twoLives();
      oneLife();
    }
    textSize(50);
    text(score, width/2-20, 50);
    if (lives == 0) {//when player runs out of lives, go to end screen
      // gameOverScreen();
      gameOver = true ;
    }
  }

  boolean hit( Pen pen, Fruit fruit) { //finds out when the pen has hit a fruit
    return ( pen.y <= fruit.y + 25 
      && pen.x >= fruit.x
      && pen.x <= fruit.x + 40 
      && pen.y >= fruit.y - 20 );
  }

  public void resetPen() {
    pen.startpos = true;
    key = TAB;
  }

  void oneLife() {//draws first life
    image(life, 500, 15, 40, 43);
  }
  void twoLives() {//draws second life
    image(life, 560, 15, 40, 43);
  }
  void threeLives() {//draws third life
    image(life, 620, 15, 40, 43);
  }

  void gameOverScreen() {//creates a gameOver screen
    background(0);
    fill(255);
    if (score > highScore) {//changes high score if player's score is higher than high score
      highScore = score;
    }
    textSize(24);
    text("Your final score is : " + score, width/2-200, height/2);//score display
    text("High score : " + highScore, width/2-100, height/2+50);
  }

  public void appleBreaks() {
    if (startpos) {//makes the broken apple start at the same position every time
      i = 0;
      k = width/2 - 50;
      startpos = false;
    }
    image(appleBreak, k, i + height/2, 70, 50);
    i += 5;//makes the broken apple move of the page
    k -= 3;
    if ( i >= height) { 
      aMove = false ;
    }
  }

  public void pineappleBreaks() {//makes the broken pineapple start at the same position every time
    if (startpos2) {
      j = 0;
      l = width/2 + 50;
      startpos2 = false;
    }
    image(pineBreak, l, j + height/2-100, 70, 70);
    j += 5;//makes the broken apple move of the page
    l += 3;
    if ( j >= height) { 
      pMove = false ;
    }
  }

  void mousePressed() {
  }
  
  boolean gameOver(){
    return gameOver;
  }
  
   String getScore(){
    return str(score);
  }
}