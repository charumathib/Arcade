class Spoke { 
  float angle ; 
  color col = #000000; 
  int num ;
  int x = 0; 
  int y = 200;



  public Spoke(color col, float angle, int num) { 
    this.col = col ;
    this.angle = angle;
    this.num = num ;
  }

  public Spoke(float angle, int num) { 
    this(#000000, angle, num);
  }



  void draw () { 
    rotate(angle);
    fill(col);
    rect(-5, 0, 10, 200);
    ellipse(x, y, 25, 25);
    fill(255);
    textSize(15);
    if (num >=10) {
      text(num, -10, 205);
    } else {
      text(num, -5, 205);
    }
  }

  String toString() { 
    return str(angle) + ":" + str(col) + ":" + str(num);
  }
}