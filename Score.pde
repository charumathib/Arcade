abstract class Score {
  private int score = 0;

  int getScore() { 
    return score ;
  }


  void incrementScore(int increment) { 
    score += increment;
  }  

  void setScore(int value) {
    score = value ; 
  }
}