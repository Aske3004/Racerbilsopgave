//populationSize: Hvor mange "controllere" der genereres, controller = bil & hjerne & sensorer
int populationSize  = 1000;
int highestFitness;
int generation=1;
int timer;
boolean displaySensors = false;

//CarSystem: Indholder en population af "controllere" 
CarSystem carSystem       = new CarSystem(populationSize);

//trackImage: RacerBanen , Vejen=sort, Udenfor=hvid, Målstreg= 100%grøn 
PImage    trackImage;

void setup() {
  size(500, 600);
  trackImage = loadImage("track.png");
}

void draw() {
  clear();
  background(255);
  fill(255);
  rect(-500, -500, 1500, 1500);
  image(trackImage, 0, 80);  
  carSystem.calculateFitness(); 
  carSystem.makeMatingpool();
  carSystem.updateAndDisplay();
  runSimulation();
  textSize(20);
  fill(0);
  textAlign(LEFT);
  text("Runtime: "+ int(millis()/1000)+ "s", 10, 20);
  text("Highest fitness: " + highestFitness, 10, 40);
  text("Current generation: " + generation, 10, 60);
  text("Current highest fitness: " + int(carSystem.bestFitness), 10, 80);
  textSize(30);
  textAlign(CENTER);
  text("Press any key to view the sensors", width/2, 580);
}

void runSimulation() {
  if (timer+10000 < millis()) {
    timer = millis();
    if (highestFitness < carSystem.bestFitness) {
      highestFitness = int(carSystem.bestFitness);
    }
    carSystem.createNew();
    for (int i=0; i<populationSize; i++) {
      carSystem.population[i].createNew();
    }
    generation+=1;
  }
}

void keyReleased() {
  if (displaySensors == false) {
    displaySensors = true;
  } else {
    displaySensors=false;
  }
}
