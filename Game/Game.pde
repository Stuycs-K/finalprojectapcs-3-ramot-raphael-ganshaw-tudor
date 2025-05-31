//Game

import java.util.*;
import java.io.*;


Map map;
ArrayList<Ghost> ghostList = new ArrayList<Ghost>();
Pacman pac;
static int tileSize = 26;



void setup()
{
  size(754,525);
  strokeWeight(0);
  textSize(20);
  int[][] mapArr = getMap(1);
  map = new Map(mapArr);
  int[] pacCoords = new int[]{0,0};
  for (int i = 0; i<map.mapDimensions()[1]; i++) {
    for (int n = 0; n<map.mapDimensions()[0]; n++) {
      if (mapArr[n][i]==0) {
        pacCoords = new int[]{n,i};
      }
    }
  }
  
  pac = new Pacman(map.getAt(pacCoords),"left");
  
  for(int i = 0; i < 4; i++){ghostList.add(new Ghost(map));}
  colorfy(ghostList);
}


void draw()
{
  drawTiles();
  fill(255,255,0);
  circle(pac.getLocation()[0],pac.getLocation()[1],tileSize/3*2);
  if (pac.getLocation()[0]==pac.getNode().getLocation()[0] && pac.getLocation()[1]==pac.getNode().getLocation()[1]) {
    pac.changeDirection();
  }
  

  for(Ghost ghost : ghostList)
  {
    fill(ghost.colors()[0], ghost.colors()[1], ghost.colors()[2]);
    int[] loc = ghost.getLocation().getLocation();
    circle(loc[0],loc[1],tileSize/3*2);
    if(frameCount % 9 == 0)
    {
    ghost.move();
    }
 
  }
  pac.move();
  fill(0);
  text("Score: "+pac.getScore(),10,20);
  
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
  n.setType(colorList.get(0));
  int[] colors1 = new int[3];
  if(n.getType() == 1){colors1 = new int[]{255,0,0};}
  if(n.getType() == 2){colors1 = new int[]{255,184,255};}
  if(n.getType() == 3){colors1 = new int[]{0,255,255};}
  if(n.getType() == 4){colors1 = new int[]{255,184,82};}
  n.setColors(colors1);
  colorList.remove(0);
 }
}
