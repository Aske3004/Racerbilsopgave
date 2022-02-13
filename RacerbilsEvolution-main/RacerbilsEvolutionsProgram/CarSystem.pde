class CarSystem {
  //CarSystem - 
  //Her kan man lave en generisk alogoritme, der skaber en optimal "hjerne" til de forhåndenværende betingelser
  float bestFitness;
  CarController[] population;
  ArrayList<CarController> matingPool;

  CarSystem(int populationSize) {
    population = new CarController[populationSize];
    for (int i=0; i<populationSize; i++) { 
      population[i] = new CarController(2);
    }
  }

  void createNew() {
    for (int i=0; i<populationSize; i++) {
      CarController child = matingPool.get(int(random(matingPool.size()))).newCarController();
      child.mutate(0.001);
      population[i] = child;
    }
  }

  void calculateFitness() {
    for (int i=0; i<populationSize; i++) {
      population[i].fitness();
    }
  }

  void makeMatingpool() {
    matingPool = new ArrayList<CarController>();
    matingPool.clear();
    float maximumFitness = 0;
    for (int i = 0; i < populationSize; i++) {
      if (population[i].fitness > maximumFitness) {
        maximumFitness = population[i].fitness;
        bestFitness = maximumFitness;
      }
    }
    for (int i = 0; i < populationSize; i++) {
      int n = int(population[i].fitness/maximumFitness*100);
      for (int j = 0; j < n; j++) {
        matingPool.add(population[i]);
      }
    }
  }

  void updateAndDisplay() {
    for (CarController carController : population) {
      if (carController.sensorSystem.whiteSensorFrameCount<=0) carController.update();
    }

    //2.) Tegner tilsidst - så sensorer kun ser banen og ikke andre biler!
    for (CarController carController : population) {
      if (carController.sensorSystem.whiteSensorFrameCount<=0) carController.display();
    }
  }
}
