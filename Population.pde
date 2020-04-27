
class Population {
  Player[] players;
  Player bestPlayer;
  int[] bestPlayerNo = new int[3];
  int gen = 1;
  
  Population(int size) {
    players = new Player[size];
    for (int i=0; i < size; i++) {
      players[i] = new Player();
    }  
  }
  
  void updateAlive() {
    for (int i=0; i < players.length; i++) {
      if (players[i].alive) {
        players[i].look();
        //players[i].think();
        players[i].move();
        if (!showBest || i == 0) players[i].draw();  // draw players
      }
    }
  }
  
  void setBest() {
    bestPlayerNo = new int[3];  // sets them to last player in pop, not ideal
    bestPlayerNo[0] = players.length-1; 
    bestPlayerNo[1] = bestPlayerNo[0];
    bestPlayerNo[2] = bestPlayerNo[0];
    
    for (int i=0; i < players.length; i++) {
      if (players[i].fitness > players[bestPlayerNo[0]].fitness) {
        bestFitness = players[i].fitness;
        bestPlayerNo[2] = bestPlayerNo[1];
        bestPlayerNo[1] = bestPlayerNo[0];
        bestPlayerNo[0] = i;
      } else if (players[i].fitness > players[bestPlayerNo[1]].fitness) {
        bestPlayerNo[2] = bestPlayerNo[1];
        bestPlayerNo[1] = i;
      } else if (players[i].fitness > players[bestPlayerNo[2]].fitness) {
        bestPlayerNo[2] = i;
      }      
    }
    bestPlayer = players[bestPlayerNo[0]].clone();
    if (saveBest) {
      saveGen(players.length/3);
      saveBest = false;
    }
  }
  
  void saveGen(float limit) {
    for (int i=0; i < limit; i++) {
      saveTable(players[i].brain.NetToTable(), "data/gen" + gen + "-fit" + bestFitness + "/car-" + i + ".csv");
    }
  }
  
  boolean done() {
    alive = 0;
    for (int i=0; i < players.length; i++) {
      if (players[i].alive) alive++;
    }
    if (alive > 0) return false;
    return true;
  }
  
  void naturalSelevtion() {
    Player[] newPlayers = new Player[players.length];
    setBest();
    newPlayers[0] = players[bestPlayerNo[0]].clone();  // top 3 survive to next
    newPlayers[1] = players[bestPlayerNo[1]].clone();
    newPlayers[2] = players[bestPlayerNo[2]].clone();
    
    newPlayers[3] = players[bestPlayerNo[0]].clone();  // and mutate
    newPlayers[4] = players[bestPlayerNo[1]].clone();
    newPlayers[5] = players[bestPlayerNo[2]].clone();
    newPlayers[3].mutate(true);
    newPlayers[4].mutate(true);
    newPlayers[5].mutate(true);
    //newCars[3] = cars[bestCarNo[0]].crossover(cars[bestCarNo[1]]);  // they also get crossed
    //newCars[4] = cars[bestCarNo[0]].crossover(cars[bestCarNo[2]]);
    //newCars[5] = cars[bestCarNo[1]].crossover(cars[bestCarNo[2]]);
    
    //newCars[6] = cars[bestCarNo[0]].crossover(cars[bestCarNo[1]]);  // and crossed + mutated
    //newCars[7] = cars[bestCarNo[0]].crossover(cars[bestCarNo[1]]);
    //newCars[8] = cars[bestCarNo[0]].crossover(cars[bestCarNo[1]]);

    
    for (int i=6; i < players.length; i++) {
      if (i < players.length/3) {  // length/2
        newPlayers[i] = newPlayers().clone();
      } else {
        newPlayers[i] = selectCar().crossover(selectCar());
      }
      newPlayers[i].mutate(false);
    }
    players = newPlayers.clone();
    gen++;
  }
  
  Player selectPlayer() {
    int fitnessSum = 0;  // long
    for (int i=0; i < players.length; i++) {
      fitnessSum += players[i].fitness;
    }
    
    int rand = floor(random(fitnessSum));
    int runningSum = 0;
    for (int i=0; i < players.length; i++) {
      runningSum += players[i].fitness;
      if (runningSum > rand) {
        return players[i]; 
      }
    }
    return players[0];  // unreachable code to keep the parser happy
  }
  
  void mutate() {
    for (int i=0; i < players.length; i++) {
      players[i].mutate(false);
    }
  }
  
  void calculateFitness() {
    for (int i=0; i < players.length; i++) {
      players[i].calculateFitness(); 
    }
  }
} 
