Population p;
ArrayList<DrawableIndividual> dl = new ArrayList<DrawableIndividual>();
int size = 50;
int gen = 0;
int progenitors = 30;
int cursor = 0;
int bounds = 500;
int ellipse_limit = 100;
int ELLIPSE_SIZE = 15;

boolean firstGen = true;

void setup(){
  size(bounds,bounds);
  background(100);
  fill(0);
  ellipse(bounds/2,bounds/2,10,10);
  p = initializePopulation();
  println(p.meanFitness());
}


void draw(){
  background(100);
  fill(0);
  stroke(255);
  ellipse(bounds/2,bounds/2,bounds-ellipse_limit,bounds-ellipse_limit);
  stroke(0);
  showInfo();
  generateNextFrame();
}

void showInfo(){
  fill(255);
  textSize(20);
  String s = "Generation: " + gen; 
  text(s,bounds/15,bounds/15);
  textSize(15);
  s = "Mean Fitness: " + p.meanFitness();
  text(s,bounds/20,bounds - bounds/15);
  s = "Gap: " + p.gap;
  text(s,bounds - bounds/5,bounds - bounds/15);
}

void generateNextFrame(){
  if (firstGen){
    for (int i = 0; i<cursor;i++){
      dl.get(i).render();
    }
  } else{
    for (int i = 0;i< size ;i++){
      if (i == cursor) {
        dl.get(i).ind = p.getIndividuals().get(i);
        dl.get(i).locateInScreen();
      }
      dl.get(i).render();
    }    
  }
  delay(50);
  updateCursor();
}


void updateCursor(){
  cursor++;  
  if (cursor == size){
    cursor = 0;
    firstGen = false;
    p.evolve();
    gen++;
    println(p.meanFitness());
  }
}
 
  
Population initializePopulation(){
  ArrayList<Individual> l = new ArrayList<Individual>();
  /*for (int i=0; i<size;i++){
    Square s = new Square();
    l.add(s);
    dl.add(new DrawableIndividual(s));
  }*/
  
  // c1 = x, y, !z
  // c2 = !x
  // c3 = !y
  // c4 = z
  HashMap<String, Boolean> c1 = new HashMap<String, Boolean>();
  c1.put("x", true);
  c1.put("y", true);
  c1.put("z", false);

  HashMap<String, Boolean> c2 = new HashMap<String, Boolean>();
  c2.put("x", false);
  
  HashMap<String, Boolean> c3 = new HashMap<String, Boolean>();
  c3.put("y", false);
  
  HashMap<String, Boolean> c4 = new HashMap<String, Boolean>();
  c4.put("z", true);
  
  Clause clause1 = new Clause(c1);
  Clause clause2 = new Clause(c2);
  Clause clause3 = new Clause(c3);
  Clause clause4 = new Clause(c4);
  
  ArrayList<Clause> formula = new ArrayList<Clause>();
  formula.add(clause1);
  formula.add(clause2);
  formula.add(clause3);
  formula.add(clause4);
  
  
  for (int i=0; i<size;i++){
    SAT s = new SAT(formula);
    l.add(s);
    dl.add(new DrawableIndividual(s));
  }
  return new Population( l ,progenitors);
}


