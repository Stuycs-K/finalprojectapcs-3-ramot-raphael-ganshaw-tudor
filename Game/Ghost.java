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
public static final int[] directionList = new int[] {UP,RIGHT,DOWN,LEFT};



public Ghost(Map map1){

  map = map1;
  int[] mapDimensions = map1.mapDimensions();
  while(location == null || location.getObject() != 5)
  {
    location = map1.getAt((int) (Math.random() * mapDimensions[0]),(int) (Math.random() * mapDimensions[1]));
    loc = new int[]{location.getLocation()[0],location.getLocation()[1]};
  }
  type = 1;
  isAfraid = false;
  direction = directionList[(int) (Math.random() * 4)];
  move(map.getAt(14,18));
}

public void movePixel(int num, MapNode pacLocation)
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
       move(pacLocation);
  }
}

public void move(MapNode pacLocation) {
  ArrayList<Integer> directions = new ArrayList<Integer>();
  if (getDirection(direction)!=null)
    directions.add(direction);
  if (getDirection(directionList[(direction+1)%4])!=null)
    directions.add(directionList[(direction+1)%4]);
  if (getDirection(directionList[(direction+3)%4])!=null)
    directions.add(directionList[(direction+3)%4]);
  if (directions.isEmpty())
    System.out.println("empty");
  int newDirection = (int)(Math.random()*directions.size());
  direction = directions.get(newDirection);
  location = getDirection(direction);
}
/*
public int pathfind(MapNode start, MapNode end, int[][] mapArr, int index)
{
 int up = 1;
 int down = 1;
 int left = 1;
 int right = 1;

 if(index > 50 || start == null ||mapArr[(start.getLocation()[1]-Game.tileSize/2)/Game.tileSize][(start.getLocation()[0]-Game.tileSize/2)/Game.tileSize] == 6 || start.getObject() == 3){return 9207;} 
 if(start.getLocation()[0] < 0 || start.getLocation()[0] > Game.screenWidth || start.getLocation()[1] < 0 || start.getLocation()[1] > Game.screenHeight)
  {
   return 9207; 
  }
 if(start.equals(end)){return 0;}
 System.out.println(Arrays.toString(start.getLocation()) + " " + Game.screenWidth);
 System.out.println((start.getLocation()[0]-Game.tileSize/2)/Game.tileSize + " " + (start.getLocation()[1]-Game.tileSize/2)/Game.tileSize);
 mapArr[(start.getLocation()[1]-Game.tileSize/2)/Game.tileSize][(start.getLocation()[0]-Game.tileSize/2)/Game.tileSize] = 6;
 up += pathfind(start.getUp(),end,mapArr,index+1);
 if(up != 1)
 {
 down += pathfind(start.getDown(),end,mapArr,index+1);
 if(down != 1)
 {
 left += pathfind(start.getLeft(),end,mapArr,index+1);
 }
 if(left != 1)
 {
 right += pathfind(start.getRight(),end,mapArr,index+1);
 }
 }
 
 int[] dirArr = new int[]{up,down,left,right};
 Arrays.sort(dirArr);
 if(index == 0){
  if(Game.framecount % 13 == 0)
  {
  if(dirArr[0] == up){direction = UP;}
  if(dirArr[0] == down){direction = DOWN;}
  if(dirArr[0] == left){direction = LEFT;}
  if(dirArr[0] == right){direction = RIGHT;}
  }
 }
 return dirArr[0];
  
}
*/


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
