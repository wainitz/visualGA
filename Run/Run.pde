Population p;
ArrayList<DrawableIndividual> dl = new ArrayList<DrawableIndividual>();
int size = 100;
int gen = 0;
int progenitors = 80;
int cursor = 0;
int bounds = 500;
int ellipse_limit = 100;
int ELLIPSE_SIZE = 15;
int DELAY = 100;


boolean firstGen = true;

void setup(){
  size(bounds,bounds);
  p = initializePopulation();
}

void draw(){
  background(100);
  fill(0);
  stroke(255);
  ellipse(bounds/2,bounds/2,bounds-ellipse_limit,bounds-ellipse_limit);
  stroke(0);
  generateNextFrame();
  showInfo();
}

void showInfo(){
  fill(255);
  textAlign(LEFT);
  textSize(20);
  String s = "Generation: " + gen; 
  text(s,bounds/15,bounds/15);
  textSize(15);
  s = "Mean Fitness: " + meanFitness();
  text(s,bounds/20,bounds - bounds/15);
  s = "Gap: " + p.gap;
  text(s,bounds - bounds/5,bounds - bounds/15);
}

void generateNextFrame(){
  if (firstGen){
    for (int i = 0; i<cursor;i++){
      dl.add(new DrawableIndividual(p.getIndividuals().get(i)));
      dl.get(i).render();
      if (dl.get(i).isChosen()){
        showChosen(dl.get(i));
      }
    }
  } else{
    for (int i = 0 ; i < size ;i++){
      if (i == cursor) {
        dl.get(i).ind = p.getIndividuals().get(i);
        dl.get(i).locateInScreen();
        if (dl.get(i).isChosen()){
          showChosen(dl.get(i));
        }
      }
      dl.get(i).render();
    }    
  }
  //delay(DELAY);
  updateCursor();
}

void showChosen(DrawableIndividual di){
  println("Found!");
  fill(255);
  textAlign(CENTER);
  textSize(50);
  String str = "Found!";
  text(str,bounds/2,bounds/3);
  for (String s : di.getIndividual().getAssignment().keySet()){
    println(s + " -> " + di.getIndividual().getAssignment().get(s));
  }
  noLoop();
}


void updateCursor(){
  cursor++; 
  if (cursor== size/4){
    p.phase1();
  }else if (cursor== size/2){
    p.phase2();
  }else if (cursor== 3*size/4){
    p.phase3();
  } else if (cursor == size){
    cursor = 0;
    firstGen = false;
    //p.evolve();
    p.phase4();
    gen++;
  }
}
 
  
Population initializePopulation(){
  ArrayList<Individual> l = new ArrayList<Individual>();
  ArrayList<Clause> formula = loadFormula();
  printFormula(formula);
  for (int i=0; i<size;i++){
    SAT s = new SAT(formula);
    l.add(s);
  }
  return new Population( l ,progenitors);
}

ArrayList<Clause> loadFormula(){
  BufferedReader reader = createReader("formula.txt");
  ArrayList<Clause> formula = new ArrayList<Clause>();
  String line;
  do {    
    try {
      line = reader.readLine();
      if (line!=null){
        String[] parts = line.split(" ");
        HashMap<String,Boolean> hm = new HashMap<String,Boolean>();
        for (String each : parts) {
          if (each.charAt(0)=='~'){
            if (hm.containsKey(each.substring(1)) && (hm.get(each.substring(1)) || hm.get(each.substring(1))==null)){
              hm.put(each.substring(1),null);
            }
            else
              hm.put(each.substring(1),false);
          }
          else{
            if (hm.containsKey(each) && (!hm.get(each) || hm.get(each)==null)){
              hm.put(each,null);
            }
            else
              hm.put(each,true);
          }
        }
        formula.add(new Clause(hm));
      }
    } catch (IOException e) {
      line = null;
    }
  } while(line!=null);
  return formula;
}

void printFormula(ArrayList<Clause> formula){
  println("Formula:");
   for (Clause c : formula){
     println(c.toString());
   }
 }
 
 float meanFitness(){
  float total = 0;
  for (DrawableIndividual di : dl){
    total+=di.getFitness();
  } 
   return total / (float) dl.size(); 
 }


