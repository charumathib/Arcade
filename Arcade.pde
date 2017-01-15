import g4p_controls.*;
PImage background ;
GImageButton pineapple, flappyBird, Aa, backToGame, leader, enter;
boolean flappySwitch, aaSwitch, ppapSwitch, gamesInitialised, leaderSwitch, nameSwitch; 
FlappyBird flappyGame ; 
Aa aaGame;
PPAP ppapGame;
static int flappyHighScore, aaHighScore, ppapHighScore ; 
PImage pineImage, flappyImage, aaImage ; 
String gameName, player ; 
LeaderBoard leaderboard;
GTextField name;
Game game ; 
FileLoad fileLoad ; 
PFont leaderFont ; 

public void setup() {
  size(700, 700);
  pineImage = loadImage("picol2-1.png");
  flappyImage = loadImage("bird_sing.png");
  aaImage = loadImage("aa-addictive-game.png");
  pineapple = new GImageButton(this, width/2-50, 200, new String[]{"picol2-1.png"} );
  flappyBird = new GImageButton(this, width/4-50, 500, new String[]{"bird_sing.png"});
  Aa = new GImageButton(this, width/4 *3-50, 490, new String[]{"aa-addictive-game.png"});
  backToGame = new GImageButton(this, 50, 10, new String[]{"backButton.png"});
  leader = new GImageButton(this, width-135, 10, new String[]{"Leader.png"});
  enter = new GImageButton(this, width/2-50, height/2+125, new String[]{"imgres-1.png"} );
  name = new GTextField(this, width/2-100, height/2, 200, 100);
  leaderboard = new LeaderBoard();
  startArcadeScreen();
  leaderFont = createFont("Monospaced-16.vlw", 16);
}

void startArcadeScreen() { 
  background = loadImage("cool-dark-backgrounds-wallpaper-2.jpg");
  image(background, 0, 0, width, height);
  writeNames();
  makeButtonsVisible(true);
  backToGame.setVisible(false);
  leader.setVisible(false);
  enter.setVisible(false);
  name.setVisible(false);
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
      enterNameScreen();
      if (nameSwitch) {
        gameOverScreen();
        nameScreenInvisible();
      }
      if (leaderSwitch) {
        leaderboard.draw();
        nameScreenInvisible();
      }
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

  if ( button == enter ) {
    nameSwitch = true ;  
    fileLoad = new FileLoad();
    player = trim(name.getText().toUpperCase().substring(0, 3));
    fileLoad.savePlayerScore(game, player);
  }

  if ( button == leader) { 
    leaderSwitch = true ;
    leaderboard = new LeaderBoard();
  }

  if ( button == backToGame ) { 
    startArcadeScreen();
    gamesInitialised = flappySwitch = aaSwitch = ppapSwitch = leaderSwitch = nameSwitch = false ;
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
    if (leaderSwitch) {
      leaderboard.draw();
      leader.setVisible(false);
      nameScreenInvisible();
    } else {
      background(0);
      showScores();
      textSize(64);
      fill(255);
      backToGame.setVisible(true);
      leader.setVisible(true);
      image(pineImage, width/2-50, 200);
      image(flappyImage, width/4-50, 500);
      image(aaImage, width/4 *3-50, 490);
    }
  }
}


void showScores() { 
  textSize(32);
  fill(#2AFF0F);
  text("Your "+ gameName + " score: " + game.getScore(), 200, 150);
  textSize(32);
  fill(#FFDC0F);
  text("High: " + ppapHighScore, width/2-35, 400);
  fill(255);
  text("High: " + ppapHighScore, width/2-38, 400);
  fill(#0F99FF);
  text("High: " + flappyHighScore, width/4-90, 600);
  fill(255);
  text("High: " + flappyHighScore, width/4-93, 600);
  fill(#FF0FE8);
  text("High: " + aaHighScore, width/4*3-30, 600);
  fill(255);
  text("High: " + aaHighScore, width/4*3-33, 600);
}
void updateHighScore() {
  int score = game.getScore();
  if ( game instanceof Aa ) {     
    aaHighScore = ( aaHighScore < score ) ? score :aaHighScore ;
    gameName = "AA";
  } else if ( game instanceof PPAP ) { 
    ppapHighScore = ( ppapHighScore < score ) ? score : ppapHighScore ;
    gameName = "PPAP" ;
  } else if ( game instanceof FlappyBird) { 
    flappyHighScore = ( flappyHighScore < score ) ? score : flappyHighScore ;
    gameName = "Flappy" ;
  }
}

void enterNameScreen() {
  background(0);
  name.setVisible(true);
  enter.setVisible(true);
}
void nameScreenInvisible() {
  name.setVisible(false);
  enter.setVisible(false);
}