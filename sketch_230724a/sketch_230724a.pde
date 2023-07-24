int[][] field;
int w = 10;

final int RED = 0;
final int GREEN = 1;
final int BLUE = 2;
int type = RED;

boolean calc = true;

void setup() {
  size(600, 600);
  frameRate(10);
  noStroke();
  //smooth(8);
  field = new int[height/w][width/w];
  for (int i=0; i<field.length; ++i) {
    for (int j=0; j<field[i].length; ++j) {
      field[i][j] = (int)random(0, 3);
    }
  }
}

void calculate() {
  int[][] temp = new int[field.length][field[0].length];

  for (int i=0; i<field.length; ++i) {
    for (int j=0; j<field[i].length; ++j) {

      int count = 0;
      for (int k=-1; k<2; ++k) {
        for (int w=-1; w<2; ++w) {
          if (k != 0 && w != 0) {
            if (i+k > -1 && i+k < field.length) {
              if (j+w > -1 && j+w < field[i].length) {
                if (field[i][j] == BLUE)
                  if (field[i+k][j+w] == RED)
                    ++count;


                if (field[i][j] == GREEN )
                  if (field[i+k][j+w] == BLUE)
                    ++count;

                if (field[i][j] == RED)
                  if (field[i+k][j+w] == GREEN)
                    ++count;
              }
            }
          }
        }
      }
      if (count >=3)
        println(count);
      if (count >=3) {
        switch(field[i][j]) {
        case RED:
          temp[i][j] = GREEN;
          break;
        case GREEN:
          temp[i][j] = BLUE;
          break;
        case BLUE:
          temp[i][j] = RED;
          break;
        }
      } else {
        temp[i][j] = field[i][j];
      }
    }
  }
  field = temp;
}

void draw() {

  for (int i=0; i<field.length; ++i) {
    for (int j=0; j<field[i].length; ++j) {
      if (field[i][j] == RED)
        fill(255, 0, 0);
      else if (field[i][j] == GREEN)
        fill(0, 255, 0);
      else if (field[i][j] == BLUE)
        fill(0, 0, 255);

      rect(j*w, i*w, w, w);
    }
  }
  if (calc) {
    calculate();
  }
  if (keyPressed) {

    switch(key) {
    case 48:
      type = RED;
      break;
    case 49:
      type = GREEN;
      break;
    case 50:
      type = BLUE;
      break;
    case 32:
      calc = !calc;
    }
  }
  if (mousePressed) {
    try {
      field[mouseY/w][mouseX/w] = type;
      println(field[mouseY/w][mouseX/w]);
    }
    catch(Exception ex) {
    }
  }
}
