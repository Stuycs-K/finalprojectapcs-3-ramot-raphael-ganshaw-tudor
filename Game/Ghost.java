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

public final int UP = '^';; // ALL OF THESE ARE SUBJECT TO CHANGE
public final int DOWN = 'v';
public final int LEFT = '<';
public final int RIGHT = '>';
public final int[] directionList = new int[] {UP,DOWN,LEFT,RIGHT};



public Ghost(Map map1){

  map = map1;
  int[] mapDimensions = map1.mapDimensions();
  while(location == null || location.getObject() != 5)
  {
    location = map1.getAt((int) (Math.random() * mapDimensions[0]),(int) (Math.random() * mapDimensions[1]));
    loc = location.getLocation();
  }
  type = 1;
  isAfraid = false;
  //direction = directionList[(int) (Math.random() * 4)];
  direction = UP;

}

public void movePixel(int num)
{
     if (direction == UP) {
        loc[0]-= num;

      }
      else if (direction == DOWN) {
        loc[0]+= num;
      }
      else if (direction == LEFT) {
         loc[1]-= num;
      }
      else if (direction == RIGHT) {
        loc[1] += num;
      } 
      
    if(loc[0] == location.getLocation()[0] && loc[1] == location.getLocation()[1])
    {
      if((int) (Math.random()*10) == 1)
        {
         direction = directionList[(int) (Math.random() * 4)];
        }
      move();
    }
}

public void move()
{
  MapNode backupLocation = location;

  if(direction == UP)
  {
    location = location.getUp();

    if(location == null)
    {
      location = backupLocation;
    }
    
  }
  if(direction == DOWN)
  {
    location = location.getDown();
    
    if(location == null)
    {
      location = backupLocation;
    }
    
  }
  if(direction == LEFT)
  {
    location = location.getLeft();
    
    if(location == null)
    {
      location = backupLocation;
    }
    
  }
  if(direction == RIGHT)
  {
    location = location.getRight();
    
    if(location == null)
    {
      location = backupLocation;
    }
   
  }
  
  
  if((int) (Math.random()*10) == 1 || getDirection(direction) == null)
    {
       ArrayList<Integer> dir = new ArrayList<Integer>();
       for(int i = 0; i < 4; i++){dir.add(directionList[i]);}
       Collections.shuffle(dir);
       direction = dir.get(0);
       while(getDirection(direction) == null)
       {
        direction = dir.get(0); 
        dir.remove(0);
       }
    }

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
