

class DrawableIndividual{
  
  int x;
  int y;
  
  Individual i;
  
  DrawableIndividual(Individual i){
    this.i = i;
    locateInScreen();    
  }
    
    
  void locateInScreen(){
    x = (int) random(0,bounds);
    y = (int) random(0,bounds); 
  }
  
  void render(){
    fill(getColor());
    ellipse(x,y,ELLIPSE_SIZE,ELLIPSE_SIZE);
  }
  
  private color getColor(){
    int component = (int) ((i.getFitness() / i.expectedMaxFitness()) * 255.0);
    int green = component;
    int red = 255 - component;
    return color(red,green,0);
  }
    
}
  
