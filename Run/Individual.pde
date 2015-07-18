interface Individual { 
  
  float getFitness();
  void calculateFitness();
  Individual crossover(Individual other);
  Individual mutate();
  float expectedMaxFitness();
  
}
  
  
