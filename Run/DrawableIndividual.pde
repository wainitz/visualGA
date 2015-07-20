class DrawableIndividual{
  
  int x;
  int y;
  
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
  }
  
  private boolean insideEllipse(int x,int y){
    return (pow((x-bounds/2),2)/pow((bounds-ellipse_limit)/2,2))+(pow((y-bounds/2),2)/pow((bounds-ellipse_limit)/2,2)) > 0.9;
  }
  
  void render(){
    fill(getColor());
    ellipse(x,y,ELLIPSE_SIZE,ELLIPSE_SIZE);
  }
  
  private color getColor(){
    int component = (int) ((ind.getFitness() / ind.expectedMaxFitness()) * 255.0);
    int green = component;
    int red = 255 - component;
    return color(red,green,0);
  }
    
}
  
