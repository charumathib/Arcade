abstract class Score {
  private int score = 0;

  int getScore() { 
    return score ;
  }


  // Helper method to increment score by 1
  void incrementScore() { 
    incrementScore(1);
  }

  void incrementScore(int increment) { 
    score += increment;
  }  

  void setScore(int value) {
    score = value ; 
  }
}