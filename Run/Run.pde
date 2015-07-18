Population p;
ArrayList<DrawableIndividual> dl = new ArrayList<DrawableIndividual>();
int size = 50;
int progenitors = 30;
int cursor = 0;
int bounds = 400;
int ELLIPSE_SIZE = 15;

boolean firstGen = true;

void setup(){
  size(bounds,bounds);
  background(0);
  p = initializePopulation();
  println(p.meanFitness());
}


void draw(){
  background(0);
  generateNextFrame();
}

void generateNextFrame(){
  if (firstGen){
    for (int i = 0; i<cursor;i++){
      dl.get(i).render();
    }
  } else{
    for (int i = 0;i< size ;i++){
      if (i == cursor) {
        dl.get(i).locateInScreen();
      }
      dl.get(i).render();
    }    
  }
  //delay(200);
  updateCursor();
}


void updateCursor(){
  cursor++;  
  if (cursor == size){
    cursor = 0;
    firstGen = false;
    p.evolve();
    replaceDrawablePopulation();
    println(p.meanFitness());
  }
}

void replaceDrawablePopulation(){
  ArrayList<Individual> al = p.getIndividuals();
  for (int i=0;i<al.size();i++){
    dl.get(i).i = al.get(i);
  }
}
  
  
Population initializePopulation(){
  ArrayList<Individual> l = new ArrayList<Individual>();
  for (int i=0; i<size;i++){
    Square s = new Square();
    l.add(s);
    dl.add(new DrawableIndividual(s));
  }
  return new Population( l ,progenitors);
}


