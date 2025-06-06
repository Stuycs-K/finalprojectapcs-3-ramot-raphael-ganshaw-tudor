//Game

import java.util.*;
import java.io.*;


Map map;
ArrayList<Ghost> ghostList = new ArrayList<Ghost>();
Pacman pac;
static int tileSize = 26;
static int powerUpTimer = 0;
int[] scaredColors = new int[] {0,0,255};
boolean pacDead = false;
int[] pacSpawn;
int immunityTimer;
static int numPellets;
int lives = 3;
static int screenWidth;
boolean gameStart = false;
boolean debug = false;
boolean invincible = false;

PImage pinky;
PImage inky;
PImage blinky;
PImage clyde;




void setup()
{
  size(754,520);
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
}

void draw()
{
  if(lives <= 0){pacDead = true;}
  if(lives > 0){pacDead = false;}
  if(numPellets == 0)
    {
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
    
    
    
    
  if(!pacDead && gameStart)
  {
  drawTiles();
  fill(255,255,0);
  circle(pac.getLocation()[0],pac.getLocation()[1],tileSize/3*2);
  if (pac.getLocation()[0]==pac.getNode().getLocation()[0] && pac.getLocation()[1]==pac.getNode().getLocation()[1]) {
    pac.changeDirection();
  }
  pac.move();
  
  drawGhosts();
  for(Ghost ghost : ghostList)
  {
    int[] loc = ghost.getLoc();
    ghost.movePixel(2,pac.getNode());
    if(Math.abs(ghost.getLoc()[0]-pac.getLocation()[0])<=2 && Math.abs(ghost.getLoc()[1]-pac.getLocation()[1])<=2)
    {
      if(!ghost.isAfraid() && immunityTimer == 0 && !invincible)
        {  
           lives--;
           if(lives > 0)
            {
             immunityTimer = 300;
             pac.setNode(map.getAt(pacSpawn));
             pac.setLoc(pac.getNode().getLocation());
             circle(pac.getLocation()[0],pac.getLocation()[1],tileSize/3*2);
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
  
  
  
  
  
  if(pac.isPoweredUp())
  {
   for(Ghost n : ghostList)
   {
    n.swapAfraid(true);
   }
  }
  
  
  if(powerUpTimer > 0){fill(255,255,255);powerUpTimer--;}
  if(immunityTimer > 0){immunityTimer--;}
  
  if(powerUpTimer == 0){
   pac.powerUp(false);
   for(Ghost n : ghostList)
     {
      n.swapAfraid(false);
     }
  }
  
  
  fill(255);
  stroke(15);
  String textString = "Score: "+pac.getScore() + " Power-Up Timer: " + powerUpTimer + " NumPellets: " + numPellets;
  if(debug)
  {
   textString += " " + invincible; 
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
    text(mouseX + " " + mouseY,mouseX,mouseY);
    
  }else{
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
    text("Pac-Man", 110,187);
    textSize(20);
    noStroke();
    rect(300,260,684-530,50);
    fill(0);
    stroke(0);
    strokeWeight(50);
    text("PLAY GAME",330,295);
    text(mouseX + " " + mouseY,mouseX,mouseY);
    
  }
}

void mouseClicked()
{
 if(!gameStart)
 {
  if(mouseX > 300 && mouseX < 454 && mouseY > 260 && mouseY < 310)
  {
   gameStart = true; 
  }
 }
 if(pacDead)
 {
  if(mouseX > 300 && mouseX < 454 && mouseY > 260 && mouseY < 310)
  {  
      numPellets = 0;
      textSize(20);
      int[][] mapArr = getMap(1);
      map = new Map(mapArr); //<>//
      for (int i = 0; i<map.mapDimensions()[1]; i++) {
        for (int n = 0; n<map.mapDimensions()[0]; n++) {
          if (mapArr[n][i]==0) {
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
  if (key == 'I' || key == 'i')
  {
   invincible = !invincible; 
  }
  if ( key == 'p' || key == 'P')
  {
   numPellets = 10; 
  }
  if ( key == 'd' || key == 'D')
  {
   debug = !debug; 
  }
  if (key == 'x' || key == 'X')
  {
   lives = 0; 
  }
  if (key == 'r' || key == 'R')
  {
   gameStart = false; 
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
{
 for(Ghost n : ghostList)
 {
   System.out.println(n.getType());
  if(n.getType() == 1){image(inky,n.getLoc()[0]-tileSize/8*3,n.getLoc()[1]-tileSize/8*3,tileSize/4*3,tileSize/4*3);}
  if(n.getType() == 2){image(pinky,n.getLoc()[0]-tileSize/8*3,n.getLoc()[1]-tileSize/8*3,tileSize/4*3,tileSize/4*3);}
  if(n.getType() == 3){image(blinky,n.getLoc()[0]-tileSize/8*3,n.getLoc()[1]-tileSize/8*3,tileSize/4*3,tileSize/4*3);}
  if(n.getType() == 4){image(clyde,n.getLoc()[0]-tileSize/8*3,n.getLoc()[1]-tileSize/8*3,tileSize/4*3,tileSize/4*3);}
 }
}
