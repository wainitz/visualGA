import java.util.ArrayList.*;

class Population{
  
  ArrayList<Individual> population;  
  int size;
  int progenitors;
  float gap = 0;
  HashMap<Individual,Integer> newbies = new HashMap<Individual,Integer>();
  ArrayList<Individual> candidates;
  
  Population(ArrayList<Individual> population, int progenitors){
    this.progenitors = progenitors;
    this.population = population;
    this.size = population.size();    
  }
  
  void phase1(){
    newbies = new HashMap<Individual,Integer>();
    candidates = select();
  }
  
  void phase2(){
    crossover(candidates);
    mutate(candidates);
  }
  
  void phase3(){
    for (int i = 0;i<progenitors;i++){
      //candidates.get(i).getFitness();
      newbies.put(candidates.get(i),null);
    }
  }
  
  void phase4(){
    population = replace(candidates);
    gap = gap/size;
  }
  
  void evolve(){
    newbies = new HashMap<Individual,Integer>();
    gap = 0;
    candidates = select();
    crossover(candidates);
    mutate(candidates);
    for (int i = 0;i<progenitors;i++){
      //candidates.get(i).getFitness();
      newbies.put(candidates.get(i),null);
    }
    population = replace(candidates);
    gap = gap/size;
  }
  
  private void sort(ArrayList<Individual> l){
    Individual aux;
    for (int i=0; i<l.size();i++){
      for (int j=i+1; j<l.size();j++){
        if (l.get(i).getFitness()<l.get(j).getFitness()){
          aux = l.get(j);
          l.set(j,l.get(i));
          l.set(i,aux);
        }
      }
    }    
  }
  
  private ArrayList<Individual> select(){
    sort(population);
    ArrayList<Individual> ret = new ArrayList<Individual>();
    for (int i = 0; i<progenitors;i++){
      ret.add(population.get(i).clone());
    }
    return ret;
  }
  
  private void crossover(ArrayList<Individual> parents){
    for (int i = 0; i<parents.size(); i+=2){
      Individual i1 = parents.get(i).crossover(parents.get(i+1));
      Individual i2 = parents.get(i+1).crossover(parents.get(i));
      
      
      parents.set(i,i1);
      parents.set(i+1,i2);      
    }
  }
  
  private void mutate(ArrayList<Individual> children){
    for (int i = 0; i< children.size();i++){
      children.get(i).mutate();
    }  
  }
  
  private ArrayList<Individual> replace(ArrayList<Individual> children){
    ArrayList<Individual> all = new ArrayList<Individual>();
    all.addAll(this.population);
    all.addAll(children);
    sort(all);
    ArrayList<Individual> ret = new ArrayList<Individual>();
    for (int i = 0; i<size;i++){
      ret.add(all.get(i));
      if (newbies.containsKey(all.get(i))){
        gap++;
      }
    }
    return ret;
  } 
    
  ArrayList<Individual> getIndividuals(){
    return population;
  } 
 
 
  float meanFitness(){
   float total = 0;
   for (int i = 0;i<size;i++){
    total+=population.get(i).getFitness();
   }
   return total / size;
  }
    
}

