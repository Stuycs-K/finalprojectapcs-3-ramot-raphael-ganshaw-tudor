//Game

import java.util.*;
import java.io.*;


Map map;
static int numPellets;

ArrayList<Ghost> ghostList = new ArrayList<Ghost>();
static int ghostMode = 1;
int ghostModeDuration = 0;
static int ghostsEaten = 0;
boolean pointsDrawn = false;

Pacman pac;
int[] pacSpawn;
int lives = 3;
boolean lostLife;
int lostLifeTimer = 0;
boolean pacDead = false;
static int powerUpTimer = 0;

int mode = 0;
static int tileSize = 30;
static int screenWidth;
static int screenHeight;
static int framecount;
boolean debug = false;
boolean invincible = false;

PImage pinky;
PImage inky;
PImage blinky;
PImage clyde;
PImage whiteGhost;
PImage blueGhost;
PImage pacI;
PImage pacLivesI;

void setup()
{
  size(870,600);
  screenHeight = height;
  screenWidth = width;
  strokeWeight(0);
  textSize(20);
  int[][] mapArr = getMap(1);
  map = new Map(mapArr);
  for (int i = 0; i<map.mapDimensions()[1]; i++) {
    for (int n = 0; n<map.mapDimensions()[0]; n++) {
      if (mapArr[n][i]==0) {
        pacSpawn = new int[]{n,i};
      }
    }
  }
  

  pac = new Pacman(map.getAt(pacSpawn),"left");
  
  for(int i = 0; i < 4; i++){ghostList.add(new Ghost(map,i+1));}
  clyde = loadImage("clyde2.png");
  inky = loadImage("inky0.png");
  pinky = loadImage("pinky2.png");
  blinky = loadImage("blinky0.png");
  whiteGhost = loadImage("scared2.png");
  blueGhost = loadImage("scared.png");
  pacLivesI = loadImage("pac11.png");
}

void draw()
{
  framecount = frameCount;
  if(lives <= 0 && mode == 2){pacDead = true;}
  if(lives > 0 || mode != 2){pacDead = false;}
  if(numPellets == 0)
    {
      delay(2000);
      int scoreNow = pac.getScore();
      textSize(20);
      int[][] mapArr = getMap(1);
      map = new Map(mapArr);
      for (int i = 0; i<map.mapDimensions()[1]; i++) {
        for (int n = 0; n<map.mapDimensions()[0]; n++) {
          if (mapArr[n][i]==0) {
            pacSpawn = new int[]{n,i};
          }
        }
      }
  

      pac = new Pacman(map.getAt(pacSpawn),"left");
      int ghostCount = ghostList.size();
      for(int n = 0; n < ghostCount; n++)
        {
          ghostList.remove(0);
        }
      for(int i = 0; i < ghostCount; i++){ghostList.add(new Ghost(map,i+1));}
      pac.changeScore(scoreNow);
    }
    
    
    
    
  if(!pacDead && mode == 2 && !lostLife)
  {
  if (pointsDrawn) {
    delay(800);
    pointsDrawn = false;
  }
  drawTiles();
  pacI = loadImage("pac" + pac.getDir() + (frameCount % 18)/6 + ".png");
  image(pacI,pac.getLocation()[0]-tileSize/2,pac.getLocation()[1]-tileSize/2,tileSize,tileSize);
  if (pac.getLocation()[0]==pac.getNode().getLocation()[0] && pac.getLocation()[1]==pac.getNode().getLocation()[1]) {
    pac.changeDirection();
  }
  pac.move();
  
  ghostModeDuration++;
  if (ghostMode==0) {
    if(ghostModeDuration>=1200) { //chase for 20 seconds
      ghostModeDuration = 0;
      ghostMode = 1;
    }
  }
  else {
    if (ghostModeDuration>=420) { //scatter for 7 seconds
      ghostModeDuration=0;
      ghostMode=0;
    }
  }
  if(ghostModeDuration==0 || powerUpTimer==361)
    for (Ghost g : ghostList) {g.turn180();}
  drawGhosts();
  for(Ghost ghost : ghostList)
  {
    int[] loc = ghost.getLoc();
    if(ghost.getType() == 1){blinky = loadImage("blinky" + ghost.getDir() + ".png");}
    if(ghost.getType() == 2){pinky = loadImage("pinky" + ghost.getDir() + ".png");}
    if(ghost.getType() == 3){inky = loadImage("inky" + ghost.getDir() + ".png");}
    if(ghost.getType() == 4){clyde = loadImage("clyde" + ghost.getDir() + ".png");}
    if (ghost.isAfraid())
      ghost.movePixel(1,pac);
    else
    { 
      if(ghost.getLoc()[0] % 2 == 0 || ghost.getLoc()[1] % 2 == 0){ghost.movePixel(1,pac);}
      ghost.movePixel(2,pac);
    }
    if(Math.abs(ghost.getLoc()[0]-pac.getLocation()[0])<=2 && Math.abs(ghost.getLoc()[1]-pac.getLocation()[1])<=2)
    {
      if(!ghost.isAfraid() && !invincible)
        {  
           lives--;
           if(lives > 0)
            {
             lostLife = true;
             delay(800);
            }
            else{pacDead = true;}
        }
      
      if(ghost.isAfraid())
        {
           ghostsEaten++;
           int scoreAdded = (int)(Math.pow(2,ghostsEaten)*100);
           pac.changeScore(scoreAdded);
           int[] gLoc = ghost.getLoc();
           ghost.die();
           drawPoints(scoreAdded,gLoc[0]-tileSize/2,gLoc[1]+tileSize/4);
           pointsDrawn = true;
        }
    }
 
  }
  if(powerUpTimer==361)
  {
   for(Ghost n : ghostList)
   {
    n.swapAfraid(true);
   }
  }
  
  
  if(powerUpTimer > 0){fill(255,255,255);powerUpTimer--;}
  
  if(powerUpTimer == 0){
   pac.powerUp(false);
   for(Ghost n : ghostList)
     {
      n.swapAfraid(false);
     }
  }
  
  
  fill(255);
  stroke(15);
  String textString = "Score: "+pac.getScore();
  if(debug)
  {
   textString += "    Power-Up Timer: " + powerUpTimer/60 + "s    NumPellets: " + numPellets + "    Invincible: " + invincible; 
  }
  text(textString,10,20);
  noStroke();
  fill(255,255,0);
  for (int i = 0; i<lives; i++) {
    image(pacLivesI,tileSize+tileSize*i,height-tileSize,tileSize,tileSize);
  }
  }
  else if(lostLife) {
    if(lostLifeTimer<100) {
      drawTiles();
      pacI = loadImage("pacd" + lostLifeTimer/10 + ".png");
      image(pacI,pac.getLocation()[0]-tileSize/2,pac.getLocation()[1]-tileSize/2,tileSize,tileSize);
      lostLifeTimer++;
    } else {
      pac.setNode(map.getAt(pacSpawn));
      pac.setLoc(pac.getNode().getLocation());
      pac.setDirection("left");
      image(pacI,pac.getLocation()[0]-tileSize/2,pac.getLocation()[1]-tileSize/2,tileSize,tileSize);
      int ghostCount = ghostList.size();
      for(int n = 0; n < ghostCount; n++)
      {
        ghostList.remove(0);
      }
      for(int i = 0; i < ghostCount; i++){ghostList.add(new Ghost(map,i+1));}
      ghostMode = 1;
      ghostModeDuration = 0;
      lostLife = false;
      lostLifeTimer = 0;
    }
  }
  else if(pacDead){
    noStroke();
    background(0,0,255);
    fill(255,255,0);
    rect(20,20,width-40,height-40);
    fill(0);
    rect(70,45,width-140,height-90);
    fill(255,255,0);
    stroke(255,0,0);
    strokeWeight(200);
    textSize(150);
    text("You Died", 160,187);
    textSize(50); //<>//
    text("Score: " + pac.getScore(), 320,250);
    textSize(20);
    noStroke();
    rect(330,260,684-500,50);
    fill(0);
    stroke(0);
    strokeWeight(50);
    text("RESET",400,295);
    
  }else if (mode == 0){ //<>//
    noStroke();
    background(0,0,255);
    fill(255,255,0);
    rect(20,20,width-40,height-40);
    fill(0); //<>//
    rect(70,45,width-140,height-90);
    fill(255,255,0);
    stroke(255,0,0);
    strokeWeight(200);
    textSize(150); //<>//
    text("Pac-Man", 160,187);
    textSize(20);
    noStroke();
    rect(330,260,684-500,50);
    fill(0); //<>//
    stroke(0);
    strokeWeight(50);
    text("PLAY GAME",380,295);
    noStroke();
    fill(255,255,0);
    rect(330,330,684-500,50);
    fill(0);
    text("INFO",400,365);

  } //<>//
  else if (mode == 1) //<>//
  { 
    noStroke();
    background(0,0,255);
    fill(255,255,0); //<>//
    rect(20,20,width-40,height-40);
    fill(0);
    rect(70,45,width-140,height-90);
    fill(255,255,0);
    stroke(255,0,0); //<>//
    strokeWeight(200); //<>// //<>//
    textSize(50);
    text("How To Play: ", 90, 100);
    textSize(20);
    text("You control the little yellow guy. Use the arrow keys to move him around.",85,150);
    text("Your goal is the collect as many pellets as you can and avoid the ghosts.",85,180); //<>//
    text("The big power pellets make the ghosts scared,",85,210);
    text("and you can eat them for points while they're blue.",85, 235);
    text("Once you collect all pellets on the map, it'll reset so you can play more.",85,265);
    text("Press backspace to go back to the menu.",85,295);
    text("Press d to show the developer commands.",85,345); //<>// //<>//
    if(debug) //<>//
 //<>// //<>//
    {
      text("Press i to toggle invincibilty.",85,375);
      text("Press x to kill Pac Man.",85,405);
      text("Press r to reset to the menu.", 85, 435); //<>// //<>// //<>//
      text("Press p to reduce pellet count to 10.",85,465); //<>// //<>//
  } //<>//
} //<>//
}
void mouseClicked()
{ //<>// //<>//
 if(mode == 0) //<>//
 { //<>// //<>// //<>//
  if(mouseX > 300 && mouseX < 454 && mouseY > 260 && mouseY < 310) //<>// //<>//
  {
   mode = 2;  //<>// //<>// //<>//
  } //<>//
  if(mouseX > 300 && mouseX < 454 && mouseY > 330 && mouseY < 380)
  { //<>// //<>//
    mode = 1;
  }
 } //<>// //<>// //<>//
 if(pacDead)
 { //<>// //<>//
  if(mouseX > 300 && mouseX < 454 && mouseY > 260 && mouseY < 310) //<>//
  {  
      numPellets = 0;
      textSize(20);
      int[][] mapArr = getMap(1);
      map = new Map(mapArr); //<>// //<>// //<>//
      for (int i = 0; i<map.mapDimensions()[1]; i++) {
        for (int n = 0; n<map.mapDimensions()[0]; n++) {
          if (mapArr[n][i]==0) { //<>//
            pacSpawn = new int[]{n,i};
          }
        }
      }
  

      pac = new Pacman(map.getAt(pacSpawn),"left");
      int ghostCount = ghostList.size(); //<>//
      for(int n = 0; n < ghostCount; n++)
        {
          ghostList.remove(0);
        }
      for(int i = 0; i < ghostCount; i++){ghostList.add(new Ghost(map,i+1));}
      lives = 3;
      pacDead = false;
      
  }
 }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      pac.setDirection("up");
    }
    else if (keyCode == DOWN) {
      pac.setDirection("down");
    }
    else if (keyCode == LEFT) {
      pac.setDirection("left");
    }
    else if (keyCode == RIGHT) {
      pac.setDirection("right");
    }
  }
  
  if ( key == 'd' || key == 'D')
  {
   debug = !debug; 
  }
  
  
  if(debug){
  if (key == 'I' || key == 'i')
  {
   invincible = !invincible; 
  }
  if ( key == 'p' || key == 'P')
  {
   numPellets = 10; 
  }
  if (key == 'x' || key == 'X')
  {
   lives = 0; 
  }
  if (key == 'r' || key == 'R')
  {  
      pacDead = true;
      mode = 0;
      numPellets = 0;
      textSize(20);
      int[][] mapArr = getMap(1);
      map = new Map(mapArr);
      for (int i = 0; i<map.mapDimensions()[1]; i++) {
        for (int n = 0; n<map.mapDimensions()[0]; n++) {
          if (mapArr[n][i]==0) {
            pacSpawn = new int[]{n,i};
          }
        }
      }
  

      pac = new Pacman(map.getAt(pacSpawn),"left");
      int ghostCount = ghostList.size();
      for(int n = 0; n < ghostCount; n++)
        {
          ghostList.remove(0);
        }
      for(int i = 0; i < ghostCount; i++){ghostList.add(new Ghost(map,i+1));}
      lives = 3;
      pacDead = false;
      
  }
  }
  if(mode == 1 && (key == 8))
  {
    mode = 0;
  }
  
}


public int[][] getMap(int mapNum)
{
  String[] lines = loadStrings("Map" + mapNum + ".txt");
  char[][] lines2 = new char[lines.length][lines[0].length()];
  for (int i = 0; i<lines.length; i++) {
    lines2[i] = lines[i].toCharArray();
  }
  int[][] arr = new int[lines.length][lines[0].length()];
  for(int i = 0; i < arr.length; i++)
  {
   for(int n = 0; n < arr[i].length; n++)
   {
     arr[i][n] = Character.getNumericValue(lines2[i][n]);
     if(arr[i][n] == 1 || arr[i][n] == 2){numPellets++;}
   }
  }

  return arr;
}

public void drawTiles() {
  for (int i = 0; i<map.mapDimensions()[1]; i++) {
    for (int n = 0; n<map.mapDimensions()[0]; n++) {
      int obj = map.getAt(n,i).getObject();
      if (obj==6)
        fill(0,0,255); //<>// //<>//
      else if (obj==3) //<>//
        fill(234,130,229); //<>//
      else
        fill(0);
      square(i*tileSize,n*tileSize,tileSize);
      fill(255,192,203);
      if (obj==1)  //<>// //<>//
        circle(i*tileSize+(tileSize/2),n*tileSize+(tileSize/2),tileSize/6); //<>// //<>//
      if (obj==2 && frameCount%30/15==0)
        circle(i*tileSize+(tileSize/2),n*tileSize+(tileSize/2),tileSize/2);
    } //<>//
  }
}

public void drawPoints(int score, int x, int y) {
  drawTiles();
  drawGhosts();
  fill(0,255,255);
  text(score,x,y);
}

public void drawGhosts()
{ //<>//
 for(Ghost n : ghostList) //<>//
 {
  if (n.isAfraid()) {
    if (powerUpTimer<120 && (powerUpTimer/20==5 || powerUpTimer/20==3 || powerUpTimer/20==1))
      image(whiteGhost,n.getLoc()[0]-tileSize/2,n.getLoc()[1]-tileSize/2,tileSize,tileSize);
    else
      image(blueGhost,n.getLoc()[0]-tileSize/2,n.getLoc()[1]-tileSize/2,tileSize,tileSize);
  }
  else {
    if(n.getType() == 1){image(blinky,n.getLoc()[0]-tileSize/2,n.getLoc()[1]-tileSize/2,tileSize,tileSize);}
    if(n.getType() == 2){image(pinky,n.getLoc()[0]-tileSize/2,n.getLoc()[1]-tileSize/2,tileSize,tileSize);}
    if(n.getType() == 3){image(inky,n.getLoc()[0]-tileSize/2,n.getLoc()[1]-tileSize/2,tileSize,tileSize);}
    if(n.getType() == 4){image(clyde,n.getLoc()[0]-tileSize/2,n.getLoc()[1]-tileSize/2,tileSize,tileSize);}
  }
 }
}
