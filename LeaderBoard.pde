class LeaderBoard { 
  IntDict flappy, ppap, aa;
 

  LeaderBoard() { 
    flappy = new IntDict(createReader("FLAPPY.txt"));
    ppap = new IntDict(createReader("PPAP.txt"));
    aa = new IntDict(createReader("AA.txt"));
    flappy.sortValuesReverse();
    ppap.sortValuesReverse();
    aa.sortValuesReverse();
  }

  void draw() { 
    background(0);
    backToGame.setVisible(true);
    textSize(50);
    fill(255);
    text("Leader Board", width/2 - 150, 60);
    drawImages();
    displayScores();
  }

  void drawImages() {
    image(flappyImage, 75, 150);
    image(pineImage, width/2-40, 95, 75, 125);
    image(aaImage, width-140, 140);
    fill(255);
    //rect(0, 225, width, 10);
  }

  void displayScores() {
    textSize(16);
    textFont(leaderFont);
    printLeaders(flappy, 80);      
    printLeaders(ppap, width/2 -40);      
    printLeaders(aa, width - 125);
  }

  void printLeaders(IntDict players, float x) { 
    float y = 260 ;
    int counter = 0 ; 
    for ( String names : players.keyArray()  ) { 
      text(names + " - " + nf(players.get(names), 3),x, y);
      y += 40 ;
      if ( ++counter > 9) { 
        break ;
      }
    }
  }
}