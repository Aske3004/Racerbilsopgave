class CarController {
  float [] gener = new float[11];
  float fitness;
  //Forbinder - Sensorer & Hjerne & Bil
  float varians             = 2; //hvor stor er variansen på de tilfældige vægte og bias
  Car bil;                    //= new Car();
  NeuralNetwork hjerne;       //= new NeuralNetwork(varians); 
  SensorSystem  sensorSystem; //= new SensorSystem();

  CarController(float variansen) {
    varians=variansen;
    bil = new Car();
    hjerne = new NeuralNetwork(varians);
    sensorSystem = new SensorSystem();

    for (int i=0; i<11; i++) {
      if (i<8) {
        gener[i]=hjerne.weights[i];
      } else {
        gener[i]=hjerne.biases[i-8];
      }
    }
  }

  void mutate(float mutationRate) {
    for (int i=0; i<gener.length; i++) {
      if (random(1)<mutationRate) {
        gener[i] += random(-0.05, 0.05);
      }
    }
  }

  CarController newCarController() {
    CarController child  = new CarController(varians);
    child.hjerne.weights = hjerne.returnWeights();
    return child;
  }

  void fitness() {
    fitness = sensorSystem.clockWiseRotationFrameCounter;
    if (sensorSystem.whiteSensorFrameCount > 0) fitness = int(fitness/2)-50;
    if (fitness<0) fitness = 0;
  }

  void update() {
    //1.)opdtarer bil 
    bil.update();
    //2.)opdaterer sensorer    
    sensorSystem.updateSensorsignals(bil.pos, bil.vel);
    //3.)hjernen beregner hvor meget der skal drejes
    float turnAngle = 0;
    float x1 = int(sensorSystem.leftSensorSignal);
    float x2 = int(sensorSystem.frontSensorSignal);
    float x3 = int(sensorSystem.rightSensorSignal);    
    turnAngle = hjerne.getOutput(x1, x2, x3);    
    //4.)bilen drejes
    bil.turnCar(turnAngle);
  }

  void createNew() {
    bil = new Car();
    sensorSystem = new SensorSystem();
  }

  void display() {
    bil.displayCar();
    if (displaySensors==true)sensorSystem.displaySensors();
  }
}
