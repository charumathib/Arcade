class FileLoad { 

  String[] aaArr = loadStrings("AA.txt");
  String[] ppapArr = loadStrings("PPAP.txt");
  String[] flappyArr = loadStrings("Flappy.txt");

  FileLoad() {
  }

  void savePlayerScore(Game game, String name) { 
    String userScore = name + "\t" + game.getScore();
    if ( game instanceof FlappyBird) { 
      flappyArr = append(flappyArr, userScore);
      saveStrings("Flappy.txt", flappyArr);
      println("appended");
    } else if ( game instanceof Aa ) { 
      aaArr = append(aaArr, userScore);
      saveStrings("AA.txt", aaArr);
    } else if ( game instanceof PPAP ) { 
      ppapArr = append(ppapArr, userScore);
      saveStrings("PPAP.txt", ppapArr);
    }
  }
}