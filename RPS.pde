// F. Limouzin 2017
// Cellular automata : Rock-Paper-Scissors

World world;

void setup () {
  size(600, 400);
  world = new World(3, 3, false, 1);
  world.generate(50);
}

void draw () {  
  background(255);
  for (int i = 0; i < 2; i++) {
    world.update();
  }
  world.display();
}