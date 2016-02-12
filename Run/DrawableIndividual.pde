class DrawableIndividual{
  
  int x;
  int y;
  
  int r;
  int g;
  
  Individual ind;
  
  DrawableIndividual(Individual ind){
    this.ind = ind;
    locateInScreen();    
  }
    
    
  void locateInScreen(){
    do {
      x = (int) random(0,bounds);
      y = (int) random(0,bounds); 
    }while(insideEllipse(x,y));
    getColor();
  }
  
  private boolean insideEllipse(int x,int y){
    return (pow((x-bounds/2),2)/pow((bounds-ellipse_limit)/2,2))+(pow((y-bounds/2),2)/pow((bounds-ellipse_limit)/2,2)) > 0.9;
  }
  
  void render(){
    fill(color(r,g,0));
    ellipse(x,y,ELLIPSE_SIZE,ELLIPSE_SIZE);
  }
  
  private void getColor(){
    int component = (int) ((ind.getFitness() / ind.expectedMaxFitness()) * 255.0);
    g = component;
    r = 255 - component;
  }
    
}
  
