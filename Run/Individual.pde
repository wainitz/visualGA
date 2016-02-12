interface Individual { 
  
  float getFitness();
  Individual crossover(Individual other);
  Individual mutate();
  Individual clone();
  HashMap<String, Boolean> getAssignment();
  
}
  
  
