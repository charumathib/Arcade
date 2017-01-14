import g4p_controls.*;
PImage background ;
GImageButton pineapple, flappyBird, Aa, backToGame;
boolean flappySwitch, aaSwitch, ppapSwitch, gamesInitialised ; 
FlappyBird flappyGame ; 
Aa aaGame;
PPAP ppapGame;
static int flappyHighScore, aaHighScore, ppapHighScore ; 
int highScore ; 

Game game ; 

public void setup() {
  size(700, 700);
  pineapple = new GImageButton(this, width/2-50, 200, new String[]{"picol2-1.png"} );
  flappyBird = new GImageButton(this, width/4-50, 500, new String[]{"bird_sing.png"});
  Aa = new GImageButton(this, width/4 *3-50, 490, new String[]{"aa-addictive-game.png"});
  backToGame = new GImageButton(this, width/2-50, 10, new String[]{"backButton.png"});

  startArcadeScreen();
}

void startArcadeScreen() { 
  background = loadImage("cool-dark-backgrounds-wallpaper-2.jpg");
  image(background, 0, 0, width, height);
  writeNames();
  makeButtonsVisible(true);
  backToGame.setVisible(false);
}


void initialiseGames() {

  if ( aaSwitch) { 
    game = new Aa();
  } else if ( flappySwitch) { 
    game = new FlappyBird();
  } else if ( ppapSwitch ) { 
    game = new PPAP();
  }
  game.setup();
  gamesInitialised = true ;
}

public void draw() {
  if ( !gamesInitialised && ( flappySwitch || aaSwitch || ppapSwitch )) { 
    initialiseGames();
  }
  if ( gamesInitialised ) { 
    if ( game.gameOver()) { 
      gameOverScreen();
    } else { 
      game.draw();
      updateHighScore();
    }
  }
}

public void handleButtonEvents(GImageButton button, GEvent event) {
  makeButtonsVisible(false);
  flappySwitch = (button == flappyBird);
  aaSwitch = ( button == Aa) ;
  ppapSwitch = ( button == pineapple );
  if ( button == backToGame ) { 
    startArcadeScreen();
    gamesInitialised = flappySwitch = aaSwitch = ppapSwitch = false ;
  }
}


public void writeNames() {
  textSize(100);
  fill(#2AFF0F);
  text("ARCADE", 157, 150);
  fill(255);
  text("ARCADE", 150, 150);
  textSize(32);
  fill(#FFDC0F);
  text("PPAP", width/2-35, 400);
  fill(255);
  text("PPAP", width/2-38, 400);
  fill(#0F99FF);
  text("Flappy Bird", width/4-90, 600);
  fill(255);
  text("Flappy Bird", width/4-93, 600);
  fill(#FF0FE8);
  text("Aa", width/4*3-30, 600);
  fill(255);
  text("Aa", width/4*3-33, 600);
}

public void mousePressed() {
  if ( gamesInitialised) { 
    game.mousePressed();
  }
}

public void makeButtonsVisible(boolean state) {
  pineapple.setVisible(state);
  flappyBird.setVisible(state);
  Aa.setVisible(state);
}

public void keyPressed() {
  if ( gamesInitialised) { 
    game.keyPressed();
  }
}  

public void gameOverScreen() {
  if (game.gameOver()) {
    background(0);
    textSize(64);
    fill(255);
    text("Score : " + game.getScore(), width/2-150, height/2-50);
    text("High Score : " + highScore, width/2-250, height/2-150);

    backToGame.setVisible(true);
  }
}

void updateHighScore() {
  int score = game.getScore();
  if ( game instanceof Aa ) {     
    aaHighScore = ( aaHighScore < score ) ? score :aaHighScore ;
    highScore = aaHighScore;
  } else if ( game instanceof PPAP ) { 
    ppapHighScore = ( ppapHighScore < score ) ? score : ppapHighScore ;
    highScore = ppapHighScore ;
  } else if ( game instanceof FlappyBird) { 
    flappyHighScore = ( flappyHighScore < score ) ? score : flappyHighScore ;
    highScore = flappyHighScore ;
  }
}