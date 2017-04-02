// F. Limouzin 2017
// Cellular automata : Rock-Paper-Scissors
// now with rainbow mode!

World world;

void setup () {
  size(600, 400);
  //               scale, nbStates (3 to 7), Moore or not VonNeumann neighbors, neighbors' distance
  world = new World(2, 7, false, 1);

  world.setMode(EnumMode.RAINBOW);

  // nb random cells at start
  world.generate(100);
}

void draw () {  
  background(255);
  for (int i = 0; i < 10; i++) {
    world.update();
  }
  world.display();
}
