import java.util.Collection;
import java.util.Iterator;

class SAT implements Individual {
  
  public SAT(ArrayList<Clause> clauses) {
    this.clauses = clauses;
    generateRandomAssignment(clauses);
  }
  
  private SAT(ArrayList<Clause> clauses, HashMap<String, Boolean> assignment) {
    this.clauses = clauses;
    this.assignment = assignment;
  }
  
  ArrayList<Clause> clauses;
  HashMap<String, Boolean> assignment;
  float fitness;
  
  void generateRandomAssignment(ArrayList<Clause> clauses){
    assignment = new HashMap<String, Boolean>(); 
    for (Clause clause : clauses) {
      for (String variable : clause.getVariables() ){
        if (!assignment.containsKey(variable)) {
          assignment.put(variable, (random(0, 1) < 0.5));
        }
      }
    }
  }
  
  HashMap<String, Boolean> getAssignment(){
    return assignment;
  }
  
  
  float getFitness() {
    float count = 0;
    for (Clause clause : clauses) {
      count += clause.eval(assignment) / (float) clauses.size();
    }
    fitness = count;
    return fitness;
  }
  
  Individual clone(){
    return new SAT(clauses,assignment);
  }
  
  Individual crossover(Individual other){
     return this; 
  }
  
  Individual mutate(){
     Iterable<String> variables = assignment.keySet();
     Iterator<String> vars = variables.iterator();
     int to_flip = (int) random(0, assignment.size());
     String var = "";
     while (to_flip >= 0) {
       var = vars.next();
       to_flip--;
     }
     assignment.put(var, !assignment.get(var));
     return this;
  } 
   
}

class Clause {
 
   public Clause(HashMap<String, Boolean> vars) {
    this.variables = vars;
   } 
  
   HashMap<String, Boolean> variables;
   
   int size() {
    return variables.size(); 
   }
   
   Collection<String> getVariables() {
      return variables.keySet(); 
   }
   
   float eval(HashMap<String, Boolean> assignment){
     for (String variable : variables.keySet()) {
      if (variables.get(variable)==null || assignment.get(variable) == variables.get(variable)){
        return 1.0;
      }
     }
     return 0.0;
   }
   
   String toString(){
     String str="";
     for (String key : variables.keySet()){
       if (variables.get(key)==null){
         str+=(key+" ~"+key+" ");
       }
       else{
       if (variables.get(key))
         str+=(key+ " ");
       else
         str+=("~"+key+" ");
       }
     }
     return str;
   }
}
