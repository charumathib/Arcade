import g4p_controls.*;
PImage background ;
GImageButton pineapple, flappyBird, Aa;
boolean flappySwitch, aaSwitch, ppapSwitch, gamesInitialised ; 
FlappyBird flappyGame ; 
Aa aaGame;
PPAP ppapGame;

Game game ; 

public void setup() {
  size(700, 700);
  background = loadImage("cool-dark-backgrounds-wallpaper-2.jpg");
  image(background, 0, 0, width, height);
  pineapple = new GImageButton(this, width/2-50, 200, new String[]{"picol2-1.png"} );
  flappyBird = new GImageButton(this, width/4-50, 500, new String[]{"bird_sing.png"});
  Aa = new GImageButton(this, width/4 *3-50, 490, new String[]{"aa-addictive-game.png"});
  writeNames();
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
    game.draw();
  }
}

public void handleButtonEvents(GImageButton button, GEvent event) {
  makeButtonsInvisible();
  flappySwitch = (button == flappyBird);
  aaSwitch = ( button == Aa) ;
  ppapSwitch = ( button == pineapple );
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
  text("Floppy Bird", width/4-90, 600);
  fill(255);
  text("Floppy Bird", width/4-93, 600);
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

public void makeButtonsInvisible() {
  pineapple.setVisible(false);
  flappyBird.setVisible(false);
  Aa.setVisible(false);
}

public void keyPressed() {
  if ( gamesInitialised) { 
    game.keyPressed();
  }
}  