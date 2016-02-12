Population p;
ArrayList<DrawableIndividual> dl = new ArrayList<DrawableIndividual>();
int size = 50;
int gen = 0;
int progenitors = 30;
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
    for (int i = 0 ; i < size ;i++){
      if (i == cursor) {
        dl.get(i).ind = p.getIndividuals().get(i);
        dl.get(i).locateInScreen();
      }
      dl.get(i).render();
    }    
  }
  delay(DELAY);
  updateCursor();
}


void updateCursor(){
  cursor++;  
  if (cursor == size){
    cursor = 0;
    firstGen = false;
    p.evolve();
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
    dl.add(new DrawableIndividual(s));
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
            if (hm.containsKey(""+each.charAt(1)) && (hm.get(""+each.charAt(1)) || hm.get(""+each.charAt(1))==null))
              hm.put(""+ each.charAt(1),null);
            else
              hm.put(""+ each.charAt(1),false);
          }
          else{
            if (hm.containsKey(""+each.charAt(0)) && (!hm.get(""+each.charAt(0)) || hm.get(""+each.charAt(0))==null))
              hm.put(""+ each.charAt(0),null);
            else
              hm.put(""+ each.charAt(0),true);
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
     for (Clause c : formula){
       println(c.toString());
     }
   }


