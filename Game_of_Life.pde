/*
                                  HOW TO PLAY
-While the game is stopped, left click and/or drag the mouse to make cells living (black)
-While the game is stopped, right click and/or drag the mouse to make cells dead (white)
-While the game is stopped, click the fifth button to clear the grid
-Use the play/stop buttons to play and stop the simulation
-While the game is running, use the plus button to increase the simulation speed (minimum one generation every 1/20 of a second)
-While the game is running, use the minus button to decrease the simulation speed (maximum one generation every 1.5 seconds)
-Default game speed is one generation every half second

*/



int[][] currentGen = new int[80][80]; // Creates the 2D array of the current generation
int[][] nextGen = new int[80][80]; // Creates the 2D array of the next generation
int cellNeighbours = 0; // Keeps track of a cell's living neighbours to determine its state in the next generation
boolean gameRunning = false;
int time = 0; // Keeps track of time to ensure the simulation doesn't run too fast
int interval = 30; // Allows the interval between generations to be adjusted

void setup() {
  size(801,901);
  for (int r = 0; r < 80; r++) {
    for (int c = 0; c < 80; c++) {
      currentGen[r][c] = 0;
      nextGen[r][c] = 0;
    }
  }
}



void draw() {
  background(255);
  time +=1;
  
  for (int r = 0; r < 80; r++) {
    for (int c = 0; c < 80; c++) {
      if (currentGen[r][c] == 1) {
        fill(0);
      } else {
        fill(255);
      }
      rect(c*10,(r*10)+100,10,10);
    }
  }
    
  fill(255);
  stroke(0);
  strokeWeight(4);
  rect(2,2.5,796,93.5);
  fill(0);

  // Creates buttons
  fill(100);
  stroke(255);
  strokeWeight(2);
  ellipse(45,49,70,70);
  ellipse(123,49,70,70);
  ellipse(201,49,70,70);
  ellipse(279,49,70,70);
  ellipse(377,49,70,70);
  
  if (gameRunning == true) {
    fill(20,230,20);
    stroke(20,230,20);
  } else {
    fill(255);
    stroke(255);
  }
  strokeWeight(1);
  triangle(34.5,32.5,34.5,66.5,63.94,49.5);
  rectMode(CENTER);
  
  if (gameRunning == false) {
    fill(230,20,20);
    stroke(230,20,20);
  } else {
    fill(255);
    stroke(255);
  }
  rect(123.5,49.5,30,30);
  
  fill(255);
  stroke(255);
  rect(201.5,49.5,40,10);
  rect(201.5,49.5,10,40);
  
  rect(279.5,49.5,40,10);
  
  
  
  rectMode(CORNER);
  
  
  arc(378,49,40,40,radians(-110),radians(180));
  fill(100);
  arc(378,49,25,25,radians(-110),radians(180));
  stroke(100);
  ellipse(378,49,25,25);
  fill(255);
  noStroke();
  triangle(353,49,370.5,49,361.75,39);
  
  
  fill(0);
  stroke(120);
  strokeWeight(1);
  
  
  // RULES
  // Any live cell with fewer than two live neighbours dies.
  // Any live cell with more than three live neighbours dies.
  // Any live cell with two or three live neighbours lives, unchanged, to the next generation.
  // Any dead cell with exactly three live neighbours will come to life.
  
  if (gameRunning == true && time == interval) {

    // Cells not on edges or corners
    for (int r = 1; r < 79; r++) {
      for (int c = 1; c < 79; c++) {
        cellNeighbours = 0;
        if (currentGen[r-1][c-1] == 1) {
          cellNeighbours += 1;
        }
        if (currentGen[r-1][c] == 1) {
          cellNeighbours += 1;
        }
        if (currentGen[r-1][c+1] == 1) {
          cellNeighbours += 1;
        }
        if (currentGen[r][c-1] == 1) {
          cellNeighbours += 1;
        }
        if (currentGen[r][c+1] == 1) {
          cellNeighbours += 1;
        }
        if (currentGen[r+1][c-1] == 1) {
          cellNeighbours += 1;
        }
        if (currentGen[r+1][c] == 1) {
          cellNeighbours += 1;
        }
        if (currentGen[r+1][c+1] == 1) {
          cellNeighbours += 1;
        }
        
        if (currentGen[r][c] == 1) {
          if (cellNeighbours == 2 || cellNeighbours == 3) {
            nextGen[r][c] = 1;
          } else {
            nextGen[r][c] = 0;
          }
        } else if (currentGen[r][c] == 0) {
          if (cellNeighbours == 3) {
            nextGen[r][c] = 1;
          } else {
            nextGen[r][c] = 0;
          }
        }
      }
    }
    
    
    // Because the grid in Conway's Game of Life is infinite, 
    // I decided to make the grid toroidal, 
    // meaning that cells will wrap around the grid.
    // This means that cells on the edges and corners 
    //of the grid need different programming to detect their neighbours.
    
    // Cells on top edge
    for (int c = 1; c < 79; c++) {
      cellNeighbours = 0;
      if (currentGen[79][c-1] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[79][c] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[79][c+1] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[0][c-1] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[0][c+1] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[1][c-1] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[1][c] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[1][c+1] == 1) {
        cellNeighbours += 1;
      }
      
      if (currentGen[0][c] == 1) {
        if (cellNeighbours == 2 || cellNeighbours == 3) {
          nextGen[0][c] = 1;
        } else {
          nextGen[0][c] = 0;
        }
      } else if (currentGen[0][c] == 0) {
        if (cellNeighbours == 3) {
          nextGen[0][c] = 1;
        } else {
          nextGen[0][c] = 0;
        }
      }
    }
    
    // Cells on bottom edge
    for (int c = 1; c < 79; c++) {
      cellNeighbours = 0;
      if (currentGen[78][c-1] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[78][c] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[78][c+1] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[79][c-1] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[79][c+1] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[0][c-1] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[0][c] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[0][c+1] == 1) {
        cellNeighbours += 1;
      }
      
      if (currentGen[79][c] == 1) {
        if (cellNeighbours == 2 || cellNeighbours == 3) {
          nextGen[79][c] = 1;
        } else {
          nextGen[79][c] = 0;
        }
      } else if (currentGen[79][c] == 0) {
        if (cellNeighbours == 3) {
          nextGen[79][c] = 1;
        } else {
          nextGen[79][c] = 0;
        }
      }
    }
    
    // Cells on left edge
    for (int r = 1; r < 79; r++) {
      cellNeighbours = 0;
      if (currentGen[r-1][79] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[r-1][0] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[r-1][1] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[r][79] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[r][1] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[r+1][79] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[r+1][0] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[r+1][1] == 1) {
        cellNeighbours += 1;
      }
      
      if (currentGen[r][0] == 1) {
        if (cellNeighbours == 2 || cellNeighbours == 3) {
          nextGen[r][0] = 1;
        } else {
          nextGen[r][0] = 0;
        }
      } else if (currentGen[r][0] == 0) {
        if (cellNeighbours == 3) {
          nextGen[r][0] = 1;
        } else {
          nextGen[r][0] = 0;
        }
      }
    }
    
    // Cells on right edge
    for (int r = 1; r < 79; r++) {
      cellNeighbours = 0;
      if (currentGen[r-1][78] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[r-1][79] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[r-1][0] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[r][78] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[r][0] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[r+1][78] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[r+1][79] == 1) {
        cellNeighbours += 1;
      }
      if (currentGen[r+1][0] == 1) {
        cellNeighbours += 1;
      }
      
      if (currentGen[r][79] == 1) {
        if (cellNeighbours == 2 || cellNeighbours == 3) {
          nextGen[r][79] = 1;
        } else {
          nextGen[r][79] = 0;
        }
      } else if (currentGen[r][79] == 0) {
        if (cellNeighbours == 3) {
          nextGen[r][79] = 1;
        } else {
          nextGen[r][79] = 0;
        }
      }
    }
    
    
    // Corner cells
    cellNeighbours = 0;
    if (currentGen[79][79] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[79][0] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[79][1] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[0][79] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[0][1] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[1][79] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[1][0] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[1][1] == 1) {
      cellNeighbours += 1;
    }
    
    if (currentGen[0][0] == 1) {
      if (cellNeighbours == 2 || cellNeighbours == 3) {
        nextGen[0][0] = 1;
      } else {
        nextGen[0][0] = 0;
      }
    } else if (currentGen[0][0] == 0) {
      if (cellNeighbours == 3) {
        nextGen[0][0] = 1;
      } else {
        nextGen[0][0] = 0;
      }
    }
    
    cellNeighbours = 0;
    if (currentGen[79][78] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[79][79] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[79][0] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[0][78] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[0][0] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[1][78] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[1][79] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[1][0] == 1) {
      cellNeighbours += 1;
    }
    
    if (currentGen[0][79] == 1) {
      if (cellNeighbours == 2 || cellNeighbours == 3) {
        nextGen[0][79] = 1;
      } else {
        nextGen[0][79] = 0;
      }
    } else if (currentGen[0][79] == 0) {
      if (cellNeighbours == 3) {
        nextGen[0][79] = 1;
      } else {
        nextGen[0][79] = 0;
      }
    }
    
    cellNeighbours = 0;
    if (currentGen[78][79] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[78][0] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[78][1] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[79][79] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[79][1] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[0][79] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[0][0] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[0][1] == 1) {
      cellNeighbours += 1;
    }
    
    if (currentGen[79][0] == 1) {
      if (cellNeighbours == 2 || cellNeighbours == 3) {
        nextGen[79][0] = 1;
      } else {
        nextGen[79][0] = 0;
      }
    } else if (currentGen[79][0] == 0) {
      if (cellNeighbours == 3) {
        nextGen[79][0] = 1;
      } else {
        nextGen[79][0] = 0;
      }
    }
    
    cellNeighbours = 0;
    if (currentGen[78][78] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[78][79] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[78][0] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[79][78] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[79][0] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[0][78] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[0][79] == 1) {
      cellNeighbours += 1;
    }
    if (currentGen[0][0] == 1) {
      cellNeighbours += 1;
    }
    
    if (currentGen[79][79] == 1) {
      if (cellNeighbours == 2 || cellNeighbours == 3) {
        nextGen[79][79] = 1;
      } else {
        nextGen[79][79] = 0;
      }
    } else if (currentGen[79][79] == 0) {
      if (cellNeighbours == 3) {
        nextGen[79][79] = 1;
      } else {
        nextGen[79][79] = 0;
      }
    }
    
    
    // Copies the cell states from the next generation array to the current generation array
    for (int r = 0; r < 80; r++) {
      for (int c = 0; c < 80; c++) {
        currentGen[r][c] = nextGen[r][c];
      }
    }

    // Clears the next generation array
    for (int r = 0; r < 80; r++) {
      for (int c = 0; c < 80; c++) {
        nextGen[r][c] = 0;
      }
    }
    
    time = 0;
    
  }
  
  
  
}


void mouseDragged() {
  if (mouseY > 100 && gameRunning == false) {
    if (mouseButton == LEFT) {
      for (int r = 0; r < 80; r++) {
        for (int c = 0; c < 80; c++) {
          if (mouseX >= (c*10)+0.05 && mouseX <= (c*10)+9.95 && mouseY >= (r*10)+100.05 && mouseY <= (r*10)+109.95) {
            currentGen[r][c] = 1;
            break;
          }
        }
      }
    } else if (mouseButton == RIGHT) {
      for (int r = 0; r < 80; r++) {
        for (int c = 0; c < 80; c++) {
          if (mouseX >= (c*10)+0.05 && mouseX <= (c*10)+9.95 && mouseY >= (r*10)+100.05 && mouseY <= (r*10)+109.95) {
            currentGen[r][c] = 0;
            break;
          }
        }
      }
    }
    
  }
  
}


void mouseClicked() {
  if (dist(45,49,mouseX,mouseY) <= 35) {
    gameRunning = true;
    time = 0;
  } else if (dist(123,49,mouseX,mouseY) <= 35) {
    gameRunning = false;
  } else if (dist(201,49,mouseX,mouseY) <= 35 && interval > 3) {
    interval -= 2;
    time = interval/2;
  } else if (dist(279,49,mouseX,mouseY) <= 35 && interval < 90) {
    interval += 2;
    time = interval/2;
  } else if (dist(377,49,mouseX,mouseY) <= 35 && gameRunning == false) {
    for (int r = 0; r < 80; r++) {
      for (int c = 0; c < 80; c++) {
        currentGen[r][c] = 0;
      }
    }
  } else if (mouseY > 100 && gameRunning == false) {
    if (mouseButton == LEFT) {
      for (int r = 0; r < 80; r++) {
        for (int c = 0; c < 80; c++) {
          if (mouseX >= (c*10)+0.05 && mouseX <= (c*10)+9.95 && mouseY >= (r*10)+100.05 && mouseY <= (r*10)+109.95) {
            currentGen[r][c] = 1;
            break;
          }
        }
      }
    } else if (mouseButton == RIGHT) {
      for (int r = 0; r < 80; r++) {
        for (int c = 0; c < 80; c++) {
          if (mouseX >= (c*10)+0.05 && mouseX <= (c*10)+9.95 && mouseY >= (r*10)+100.05 && mouseY <= (r*10)+109.95) {
            currentGen[r][c] = 0;
            break;
          }
        }
      }
    }
  }
  
}
