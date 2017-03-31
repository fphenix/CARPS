// Fred Limouzin 2017

class World {
  Cell[][] cells;
  int caw;
  int cah;
  int scale;
  boolean moore_notVonNeumann;
  int neighborDistance;
  int nbStates;

  World (int tscl, int tnbs, boolean tMorVonN, int td) {
    this.scale = tscl;
    this.caw = floor(1.0*width/this.scale);
    this.cah = floor(1.0*height/this.scale);
    this.moore_notVonNeumann = tMorVonN;
    this.neighborDistance = td;
    this.nbStates = tnbs;
    cells = new Cell[this.caw][this.cah];
    for (int x = 0; x < this.caw; x++) {
      for (int y = 0; y < this.cah; y++) {
        cells[x][y] = new Cell(new PVector(x, y), this.scale, this.nbStates);
      }
    }
  }

  void spawn (int x, int y, int state) {
    cells[x][y].setState(state);
  }

  void generate (int nbinit) {
    int x, y, state;
    for (int n = 0; n < nbinit; n++) {
      x = floor(random(this.caw));
      y = floor(random(this.cah));
      state = floor(random(this.nbStates));
      this.spawn(x, y, state);
    }
  }

  void setVonNeumann() {
    this.moore_notVonNeumann = false;
  }

  void setMoore() {
    this.moore_notVonNeumann = true;
  }

  int wrap (int a, int wa) {
    return (a < 0) ? wa+a : (a >= wa) ? a-wa : a;
  }

  void fight (int x, int y) {
    int v;
    int m, n;
    int currState;
    int neighborState;
    currState = cells[x][y].state;
    if (currState < 0) {
      return;
    }
    for (int i = -this.neighborDistance; i <= this.neighborDistance; i++) {
      for (int j = -this.neighborDistance; j <= this.neighborDistance; j++) {
        v = abs(i)+abs(j);
        if ((v > 0) && (this.moore_notVonNeumann || (v <= this.neighborDistance))) { // is a neighbor
          m = wrap(x+i, this.caw); 
          n = wrap(y+j, this.cah);
          neighborState = cells[m][n].state;
          if (neighborState < 0) {
            this.spawn(m, n, currState);
          } else if (wrap(currState+1, this.nbStates) == neighborState) { // perdu
            cells[x][y].weakens();
            cells[m][n].strengthens();
          }
        }
      }
    }
  }

  void update () {
    for (int x = 0; x < this.caw; x++) {
      for (int y = 0; y < this.cah; y++) {
        this.fight(x, y);
      }
    }
    for (int x = 0; x < this.caw; x++) {
      for (int y = 0; y < this.cah; y++) {
        cells[x][y].update();
      }
    }
  }

  void display () {
    color c;
    noStroke();
    for (int x = 0; x < this.caw; x++) {
      for (int y = 0; y < this.cah; y++) {
        switch (cells[x][y].state) {
        case 0:
          c = color(255, 0, 0);
          break;
        case 1:
          c = color(0, 255, 0);
          break;
        case 2:
          c = color(0, 0, 255);
          break;
        case 3:
          c = color(255, 0, 255);
          break;
        case 4:
          c = color(0, 255, 255);
          break;
        case 5:
          c = color(255, 255, 0);
          break;
        default:
          c = color(255);
        }
        fill(c);
        rect(x*this.scale, y*this.scale, this.scale, this.scale);
      }
    }
  }
}
