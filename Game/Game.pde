//Game

import java.util.*;
import java.io.*;


Map map;
ArrayList<Ghost> ghostList = new ArrayList<Ghost>();
Pacman pac;
static int tileSize = 30;
static int powerUpTimer = 0;
int[] scaredColors = new int[] {0,0,255};
boolean pacDead = false;
int[] pacSpawn;
static int numPellets;
int lives = 3;
static int screenWidth;
static int screenHeight;
int mode = 0;
static int ghostMode = 1;
int ghostModeDuration = 0;
boolean debug = false;
static int framecount;

boolean invincible = false;

PImage pinky;
PImage inky;
PImage blinky;
PImage clyde;
PImage whiteGhost;
PImage blueGhost;


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
  clyde = loadImage("clyde.png");
  inky = loadImage("inky.png");
  pinky = loadImage("pinky.png");
  blinky = loadImage("blinky.png");
  whiteGhost = loadImage("WhiteGhost.png");
  blueGhost = loadImage("BlueGhost.png");
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
    
    
    
    
  if(!pacDead && mode == 2)
  {
  drawTiles();
  fill(255,255,0);
  circle(pac.getLocation()[0],pac.getLocation()[1],tileSize/3*2);
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
  boolean lostLife = false;
  for(Ghost ghost : ghostList)
  {
    int[] loc = ghost.getLoc();
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
            }
            else{pacDead = true;}
        }
      
      if(ghost.isAfraid())
        {
           ghost.die(); 
           pac.changeScore(200);
        }
      
    }
 
  }
  if (lostLife) {
    delay(2000);
    pac.setNode(map.getAt(pacSpawn));
    pac.setLoc(pac.getNode().getLocation());
    pac.setDirection("left");
    circle(pac.getLocation()[0],pac.getLocation()[1],tileSize/3*2);
    int ghostCount = ghostList.size();
    for(int n = 0; n < ghostCount; n++)
    {
      ghostList.remove(0);
    }
    for(int i = 0; i < ghostCount; i++){ghostList.add(new Ghost(map,i+1));}
    ghostMode = 1;
    ghostModeDuration = 0;
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
  String textString = "Score: "+pac.getScore() + "    Power-Up Timer: " + powerUpTimer/60 + "s    NumPellets: " + numPellets;
  if(debug)
  {
   textString += "    Invincible: " + invincible; 
  }
  text(textString,10,20);
  noStroke();
  fill(255,255,0);
  for (int i = 0; i<lives; i++) {
    circle(tileSize+tileSize*i,height-(tileSize/2),tileSize/3*2);
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
    text("You Died", 110,187);
    textSize(50);
    text("Score: " + pac.getScore(), 290,250);
    textSize(20);
    noStroke();
    rect(300,260,684-530,50);
    fill(0);
    stroke(0);
    strokeWeight(50);
    text("RESET",350,295);
    
  }else if (mode == 0){
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
    text("Pac-Man", 110,187); //<>//
    textSize(20);
    noStroke();
    rect(300,260,684-530,50);
    fill(0);
    stroke(0);
    strokeWeight(50);
    text("PLAY GAME",330,295);
    noStroke();
    fill(255,255,0);
    rect(300,330,684-530,50);
    fill(0);
    text("INFO",355,365); //<>//

  }
  else if (mode == 1)
  { //<>// //<>//
    noStroke();
    background(0,0,255);
    fill(255,255,0);
    rect(20,20,width-40,height-40);
    fill(0);
    rect(70,45,width-140,height-90);
    fill(255,255,0);
    stroke(255,0,0);
    strokeWeight(200); //<>//
    textSize(50);
    text("How To Play: ", 80, 100);
    textSize(20);
    text("You control the little yellow guy. Use the arrow keys to move him around.",75,150);
    text("Your goal is the collect as many pellets as you can and avoid the ghosts.",75,180);
    text("The big power pellets make the ghosts scared,",75,210);
    text("and you can eat them for points while they're blue.",75, 235);
    text("Once you collect all pellets on the map, it'll reset so you can play more.",75,265); //<>//
    text("Press backspace to go back to the menu.",75,295);
    text("Press d to show the developer commands.",75,345);
    if(debug) //<>//
    { //<>//
      text("Press i to toggle invincibilty.",75,375);
      text("Press x to kill Pac Man.",75,405);
      text("Press r to reset to the menu.", 75, 435);
      text("Press p to reduce pellet count to 10.",75,465); //<>// //<>// //<>//
    }
  }
}

void mouseClicked()
{
 if(mode == 0) //<>//
 {
  if(mouseX > 300 && mouseX < 454 && mouseY > 260 && mouseY < 310)
  {
   mode = 2;  //<>// //<>//
  }
  if(mouseX > 300 && mouseX < 454 && mouseY > 330 && mouseY < 380)
  {
    mode = 1;
  }
 } //<>//
 if(pacDead)
 { //<>//
  if(mouseX > 300 && mouseX < 454 && mouseY > 260 && mouseY < 310) //<>//
  {  
      numPellets = 0;
      textSize(20);
      int[][] mapArr = getMap(1);
      map = new Map(mapArr); //<>//
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
      for(Ghost g : ghostList){g.move(pac);}
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
      for(Ghost g : ghostList){g.move(pac);}
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

public int[][] getMap(int mapNum, int in)
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
   }
  }

  return arr;
}
public void drawTiles() {
  for (int i = 0; i<map.mapDimensions()[1]; i++) {
    for (int n = 0; n<map.mapDimensions()[0]; n++) {
      int obj = map.getAt(n,i).getObject();
      if (obj==6)
        fill(0,0,255);
      else if (obj==3)
        fill(234,130,229);
      else
        fill(0);
      square(i*tileSize,n*tileSize,tileSize);
      fill(255,192,203);
      if (obj==1) 
        circle(i*tileSize+(tileSize/2),n*tileSize+(tileSize/2),tileSize/6);
      if (obj==2)
        circle(i*tileSize+(tileSize/2),n*tileSize+(tileSize/2),tileSize/2);
    }
  }
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
