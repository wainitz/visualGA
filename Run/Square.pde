class Square implements Individual{
  
  int state;
  Float fitness;
  
  Square(){
    state = (int)random(0,100);
    fitness = null;
  }
  
  Square(int state){
    this.state = state;
    fitness = null;
  }
  
  float getFitness(){
    if (fitness == null){
      calculateFitness();
    }
    return fitness;
  }
  
  void calculateFitness(){
     fitness = state*state*1.0;
  }
    
  
  Individual crossover(Individual other){
    //Square otherSquare = (Square) other;
    //state = (state & 0xFF00) | (otherSquare.state & 0x00FF);
    return new Square((int) random(0,100));    
  }
  
  Individual mutate(){
    //TODO
    return this;
  }
  
  float expectedMaxFitness(){
    return 100*100;
  }
  
}
