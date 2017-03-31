class Cell {
  PVector pos;
  int state;
  int prevstate;
  int nbStates;
  int health;
  int scale;

  Cell (PVector tpos, int tscl, int tnbs) {
    this.pos = new PVector(tpos.x, tpos.y);
    this.state = -1;
    this.prevstate = this.state;
    this.nbStates = tnbs;
    this.health = 10;
    this.scale = tscl;
  }

  void setState(int t) {
    this.state = t;
  }

  int wrap (int a, int wa) {
    return (a < 0) ? wa+a : (a >= wa) ? a-wa : a;
  }

  void update () {
    this.prevstate = this.state;
    if (this.health == 0) {
      this.health = 10;
      this.state = (this.state + 1) % this.nbStates;
    }
  }

  void strengthens () {
    this.health = min(this.health+1, 10);
  }

  void weakens () {
    this.health = max(this.health-1, 0);
  }
}