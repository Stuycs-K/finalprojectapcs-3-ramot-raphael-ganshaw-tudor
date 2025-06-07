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

public static final int UP = 0;; // ALL OF THESE ARE SUBJECT TO CHANGE
public static final int DOWN = 2;
public static final int LEFT = 3;
public static final int RIGHT = 1;
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
  isAfraid = false;
  direction = directionList[(int) (Math.random() * 4)];
  move(map.getAt(14,18));
}

public void movePixel(int num, int[] pacLocation)
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
       move(pacLocation);
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
public void move(int[] pacLocation) {
  //make arraylist of possible directions
  ArrayList<Integer> directions = new ArrayList<Integer>();
  if (getDirection(direction)!=null)
    directions.add(direction);
  if (getDirection(directionList[(direction+1)%4])!=null)
    directions.add(directionList[(direction+1)%4]);
  if (getDirection(directionList[(direction+3)%4])!=null)
    directions.add(directionList[(direction+3)%4]);
  
  if (isAfraid()) {
    int newDirection = (int)(Math.random()*directions.size());
  }
  int[] target;
  //blinky
  if (type==1) {
    target = 
  }
  for (int i = 0; i<directions.size(); i++) {
      
  }
  direction = directions.get(newDirection);
  location = getDirection(direction);
}

public double calcDist(int[] loc1, int[] loc2) {
  return Math.sqrt((double)(Math.pow(loc1[0]-loc2[0],2)+Math.pow(loc1[1]-loc2[1],2));
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
  move(map.getAt(14,18));
}






public MapNode getDirection(int heading)
{
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
