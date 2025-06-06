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
int mode = 0;
boolean debug = false;



boolean invincible = false;




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
  
  for(int i = 0; i < 4; i++){ghostList.add(new Ghost(map));}
  colorfy(ghostList);
  //numPellets = 5;
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
      for(int i = 0; i < ghostCount; i++){ghostList.add(new Ghost(map));}
      colorfy(ghostList);
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

  for(Ghost ghost : ghostList)
  {
    if(powerUpTimer == 0)
    {
      fill(ghost.colors()[0], ghost.colors()[1], ghost.colors()[2]);
    }
    else
    {
      fill(scaredColors[0],scaredColors[1],scaredColors[2]);
    }
    
    
    int[] loc = ghost.getLoc();
    circle(loc[0],loc[1],tileSize/3*2);
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
    text("Pac-Man", 110,187);
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
    text("INFO",355,365);

  }
  else if (mode == 1)
  {
    noStroke();
    background(0,0,255);
    fill(255,255,0);
    rect(20,20,width-40,height-40);
    fill(0);
    rect(70,45,width-140,height-90);
    fill(255,255,0);
    stroke(255,0,0);
    strokeWeight(200);
    textSize(50);
    text("How To Play: ", 80, 100);
    textSize(20);
    text("You control the little yellow guy. Use the arrow keys to move him around.",75,150);
    text("Your goal is the collect as many pellets as you can and avoid the ghosts.",75,180);
    text("The big power pellets make the ghosts scared,",75,210);
    text("and you can eat them for points while they're blue.",75, 235);
    text("Once you collect all pellets on the map, it'll reset so you can play more.",75,265);
    text("Press backspace to go back to the menu.",75,295);
    text("Press d to show the developer commands.",75,345);
    if(debug)
    {
      text("Press i to toggle invincibilty.",75,375);
      text("Press x to kill Pac Man.",75,405);
      text("Press r to reset to the menu.", 75, 435);
      text("Press p to reduce pellet count to 10.",75,465);
    }
    
    
    
  }
}

void mouseClicked()
{
 if(mode == 0)
 {
  if(mouseX > 300 && mouseX < 454 && mouseY > 260 && mouseY < 310)
  {
   mode = 2; 
  }
  if(mouseX > 300 && mouseX < 454 && mouseY > 330 && mouseY < 380)
  {
    mode = 1;
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
      int ghostCount = ghostList.size();
      for(int n = 0; n < ghostCount; n++)
        {
          ghostList.remove(0);
        }
      for(int i = 0; i < ghostCount; i++){ghostList.add(new Ghost(map));}
      colorfy(ghostList);
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
   mode = 0;
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
        fill(0,0,255);
      else
        fill(0);
      square(i*tileSize,n*tileSize,tileSize);
      fill(234,130,229);
      if (obj==1) 
        circle(i*tileSize+(tileSize/2),n*tileSize+(tileSize/2),tileSize/6);
      if (obj==2)
        circle(i*tileSize+(tileSize/2),n*tileSize+(tileSize/2),tileSize/2);
    }
  }
}



public static void colorfy(ArrayList<Ghost> arr)
{
 ArrayList<Integer> colorList = new ArrayList<Integer>();
 for(int i = 1; i < 5; i++){colorList.add(i);}
 Collections.shuffle(colorList);
 for(Ghost n : arr)
 {

  if(colorList.size() == 0){n.setType(1); n.setColors(new int[]{255,0,0});}
  n.setType(colorList.get(0)); //<>//
  int[] colors1 = new int[3];
  if(n.getType() == 1){colors1 = new int[]{255,0,0};}
  if(n.getType() == 2){colors1 = new int[]{255,184,255};}
  if(n.getType() == 3){colors1 = new int[]{0,255,255};}
  if(n.getType() == 4){colors1 = new int[]{255,184,82};}
  n.setColors(colors1);
  colorList.remove(0);
 }
}
