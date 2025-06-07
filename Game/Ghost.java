import java.util.*;
import java.io.*;

public class Ghost{

private MapNode location;
private int[] loc;
private int type; // For different ghost types, Blinky (red), Inky (blue), Pinky (pink), and Clyde (orange)
private boolean isAfraid;
private int direction;
private Map map;
private int[] colors;

private static int[] blinkyLoc;

public static final int UP = 0;; // ALL OF THESE ARE SUBJECT TO CHANGE
public static final int DOWN = 2;
public static final int LEFT = 1;
public static final int RIGHT = 3;
public static final int[] directionList = new int[] {UP,LEFT,DOWN,RIGHT};



public Ghost(Map map1, int type){

  map = map1;
  int[] mapDimensions = map1.mapDimensions();
  while(location == null || location.getObject() != 5)
  {
    location = map1.getAt((int) (Math.random() * mapDimensions[0]),(int) (Math.random() * mapDimensions[1]));
    loc = new int[]{location.getLocation()[0],location.getLocation()[1]};
  }
  this.type = type;
  if (type==1)
    blinkyLoc = loc;
  isAfraid = false;
  direction = directionList[(int) (Math.random() * 4)];
}

public void movePixel(int num, Pacman pac)
{
  if(location != null)
  {
     if (direction == UP) {
        loc[1]-= num;
      }
      else if (direction == DOWN) {
        loc[1]+= num;
      }
      else if (direction == LEFT) {
         loc[0]-= num;
         if(loc[0] < 0){loc[0] += Game.screenWidth;}
      }
      else if (direction == RIGHT) {
        loc[0] += num;
        if(loc[0] > Game.screenWidth){loc[0] -= Game.screenWidth;}
      } 
      

      if(loc[0] == location.getLocation()[0] && loc[1] == location.getLocation()[1])
       move(pac);
  }
}


/*
all ghosts take the shortest path to the target spot, calculated by distance formula. 
if equal, the priorities are up, left, down, right
in chase mode:
blinky's target tile is pacman's location. 
pinky's is the tile four in front of pacman, or four up and four left if he is faced upwards
inky's is found by rotating the vector from the tile two in front of pacman (or two up and two left
  if faced up) to blinky and rotating it 180 degrees
clyde's target is pacman when 8 or more tiles away. when less, the target is same as in scatter mode

in scatter mode:
blinky's target is top right
pinky's is top left
inky's is bottom right
clyde's is bottom left

switch between chase for 20 seconds, scatter for 7
all move randomly when afraid and slower
all do 180 when switching between modes
*/
public void move(Pacman pac) {
  //make arraylist of possible directions
  ArrayList<Integer> directions = new ArrayList<Integer>();
  if (getDirection(direction)!=null)
    directions.add(direction);
  if (getDirection(directionList[(direction+1)%4])!=null)
    directions.add(directionList[(direction+1)%4]);
  if (getDirection(directionList[(direction+3)%4])!=null)
    directions.add(directionList[(direction+3)%4]);
    
  int[] target = new int[2];
  int newDirection;
  if (isAfraid()) {
    newDirection = (int)(Math.random()*directions.size());
  }
  if (Game.ghostMode==0) {//if in chase mode
    //blinky
    if (type==1) {
      target = pac.getLocation();
    }
    //pinky
    else if (type==2) {
      if (pac.getDirection().equals("up"))
        target = new int[]{pac.getLocation()[0]-Game.tileSize*4,pac.getLocation()[1]-Game.tileSize*4};
      if (pac.getDirection().equals("down"))
        target = new int[]{pac.getLocation()[0],pac.getLocation()[1]+Game.tileSize*4};
      if (pac.getDirection().equals("left"))
        target = new int[]{pac.getLocation()[0]-Game.tileSize*4,pac.getLocation()[1]};
      if (pac.getDirection().equals("right"))
        target = new int[]{pac.getLocation()[0]+Game.tileSize*4,pac.getLocation()[1]};
    }
    //inky
    else if (type==3) {
      int[] start = new int[2];
      if (pac.getDirection().equals("up"))
        start = new int[]{pac.getLocation()[0]-Game.tileSize*2,pac.getLocation()[1]-Game.tileSize*2};
      else if (pac.getDirection().equals("down"))
        start = new int[]{pac.getLocation()[0],pac.getLocation()[1]+Game.tileSize*2};
      else if (pac.getDirection().equals("left"))
        start = new int[]{pac.getLocation()[0]-Game.tileSize*2,pac.getLocation()[1]};
      else if (pac.getDirection().equals("right"))
        start = new int[]{pac.getLocation()[0]+Game.tileSize*2,pac.getLocation()[1]};
      target = new int[]{start[0]*2-pac.getLocation()[0],start[1]*2-pac.getLocation()[1]};
    }
    //clyde
    else if (type==4) {
      if(calcDist(loc,pac.getLocation())>8)
        target = pac.getLocation();
      else
        target = new int[]{0,Game.screenHeight};
    }
  }
  else if (Game.ghostMode==1) {
    if (type==1)
      target = new int[]{Game.screenWidth,0};
    else if (type==2)
      target = new int[]{0,0};
    else if (type==3)
      target = new int[]{Game.screenWidth,Game.screenHeight};
    else if (type==4)
      target = new int[]{0,Game.screenHeight};
  }
  
  double[] distances = new double[directions.size()];
  for (int i = 0; i<directions.size(); i++) {
      int dir = directions.get(i);
      if (dir==UP)
        distances[i] = calcDist(target,new int[]{loc[0],loc[1]-Game.tileSize});
      else if (dir==DOWN)
        distances[i] = calcDist(target,new int[]{loc[0],loc[1]+Game.tileSize});
      else if (dir==LEFT)
        distances[i] = calcDist(target,new int[]{loc[0]-Game.tileSize,loc[1]});
      else if (dir==RIGHT)
        distances[i] = calcDist(target,new int[]{loc[0]+Game.tileSize,loc[1]});
  }
  newDirection = directions.get(0);
  double shortestDist = distances[0];
  for (int i = 1; i<directions.size(); i++) {
    if (distances[i]<shortestDist) {
      newDirection = directions.get(i);
      shortestDist = distances[i];
    }
    else if (distances[i]==shortestDist) {
      if (directions.get(i)<newDirection) {
        newDirection = directions.get(i);
      }
    }
  }
  
  direction = newDirection;
  location = getDirection(direction);
}

public void turn180() {
  direction = (direction+2)%4;
}

public double calcDist(int[] loc1, int[] loc2) {
  return Math.sqrt((double)(Math.pow(loc1[0]-loc2[0],2)+Math.pow(loc1[1]-loc2[1],2)));
}

public void die(){
   while(location == null || location.getObject() != 5)
  {
    int[] mapDimensions = map.mapDimensions();
    location = map.getAt((int) (Math.random() * mapDimensions[0]),(int) (Math.random() * mapDimensions[1]));
    loc = location.getLocation();
  }
  type = 1;
  isAfraid = false;
  direction = directionList[(int) (Math.random() * 4)];
}






public MapNode getDirection(int heading)
{
  if(location == null){return null;}
  if(heading == UP){return location.getUp();}
  if(heading == DOWN){return location.getDown();}
  if(heading == LEFT){return  location.getLeft();}
  if(heading == RIGHT){return location.getRight();}
  return null;
}

public MapNode getLocation()
{
  return location;
}

public int[] getLoc()
{
  return loc;
}

public int getType()
{
  return type;
}

public void setType(int n)
{
 type = n; 
}


public boolean isAfraid()
{
  return isAfraid;
}

public void swapAfraid(boolean t)
{
  isAfraid = t;
}

public int getIntDirection()
{
  return direction;
}

public void setIntDirection(int n)
{
 direction = n; 
}

public char getCharDirection()
{
  return (char) direction;
}

public int[] colors()
{
  return colors;
}

public void setColors(int[] colorList)
{
 colors = colorList; 
}




public String debugToString(){
  String result = "";
  String n = null;
  if(location != null){n = Arrays.toString(location.getLocation());}
  result += "Location: (" + n + ")\nType: " + type + "\nisAfraid: " + isAfraid + "\nDirection: " + (char) direction;
  return result + "\n" + Arrays.toString(loc);
}

}
