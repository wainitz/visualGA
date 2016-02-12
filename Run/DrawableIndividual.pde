class DrawableIndividual{
  
  int x;
  int y;
  
  int r;
  int g;
  
  float fit;
  
  
  Individual ind;
  
  boolean chosen = false;
  
  DrawableIndividual(Individual ind){
    this.ind = ind;
    locateInScreen();    
  }
  
  
  Individual getIndividual(){
    return ind;
  }
  
  float getFitness(){
    return fit;
  }
    
  void locateInScreen(){
    do {
      x = (int) random(0,bounds);
      y = (int) random(0,bounds); 
    }while(insideEllipse(x,y));
    getColorAndFitness();
  }
  
  private boolean insideEllipse(int x,int y){
    return (pow((x-bounds/2),2)/pow((bounds-ellipse_limit)/2,2))+(pow((y-bounds/2),2)/pow((bounds-ellipse_limit)/2,2)) > 0.9;
  }
  
  void render(){
    fill(color(r,g,0));
    ellipse(x,y,ELLIPSE_SIZE,ELLIPSE_SIZE);
  }
  
  private void getColorAndFitness(){
    float f = ind.getFitness();
    fit = f;
    if (f == 1.0){
      chosen = true;
    }
    int component = (int) (f * 255.0);
    g = component;
    r = 255 - component;
  }
  
  boolean isChosen(){
    return chosen;
  }
  
}
  
