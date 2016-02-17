Visualisation of a [Genetic Algorithm](https://en.wikipedia.org/wiki/Genetic_algorithm) to solve SAT using [Processing](https://processing.org/)
=========

The algorithm initializes a population of posible solutions to the SAT formula. After that it advances through "generations" until it finds the solution. In each generation:

1. It finds the best individuals (those who are closer to the solution) to be the "parents" of the next generation.
2. It crosses over this individuals swapping their literal values in order to create the next generation.
3. It mutates randomly some of the individuals of the new generation
4. It replaces the original population picking the best candidates from the previous generation and the new one

## Visualisation

The visualisation imitates the view of a microscope where each individual of the population is represented with a color which is proportional to its fitness (how close it is to be one solution). Red individuals are far away from the solution and green individuals are closer. 


## How to run

Download or clone this repository and then insert the SAT formula in conjuntive normal form in the file ***formula.txt*** with the following format:

* Each line is a clause (disjunction of literals)
* Each literal is separated with a blank space
* Negative literals are specified with **~**
* SAT formula will be the conjunction of clauses

*For example: (A or B or C) AND ((not A) or C) AND (not B) will be:*

```
A B C
~A C
~B
```
After, open Run.pde and press play.

## Screenshots

![start](https://raw.githubusercontent.com/wainitz/visualGA/master/Run/img/start.png)

![evolution](https://raw.githubusercontent.com/wainitz/visualGA/master/Run/img/evolution.png)






