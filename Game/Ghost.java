import java.util.*;
import java.io.*;

public class Ghost{

private MapNode location;
private int type; // For different ghost types, Blinky (red), Inky (blue), Pinky (pink), and Clyde (orange)
private boolean isAfraid;
private int direction;
private Map map;

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
  }
  type = 1;
  isAfraid = false;
  direction = directionList[(int) (Math.random() * 4)];

}


public void move()
{
  MapNode backupLocation = location;

  if(direction == UP)
  {
    location = location.getUp();
    if(location == null || !map.isOnScreen(location))
    {
      location = backupLocation;
      direction = DOWN;
  //  location = location.getDown();
    }
  }
  if(direction == DOWN)
  {
    location = location.getDown();
    if(location == null || !map.isOnScreen(location))
    {
      location = backupLocation;
      direction = UP;
  //  location = location.getUp();
    }
  }
  if(direction == LEFT)
  {
    location = location.getLeft();
    if(location == null || !map.isOnScreen(location))
    {
      location = backupLocation;
      direction = RIGHT;
  //  location = location.getRight();
    }
  }
  if(direction == RIGHT)
  {
    location = location.getRight();
    if(location == null || !map.isOnScreen(location))
    {
      location = backupLocation;
      direction = LEFT;
  //  location = location.getLeft();
    }
  }
}


public MapNode getLocation()
{
  return location;
}

public int getType()
{
  return type;
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


public String debugToString(){
  String result = "";
  String n = null;
  if(location != null){n = Arrays.toString(location.getLocation());}
  result += "Location: (" + n + ")\nType: " + type + "\nisAfraid: " + isAfraid + "\nDirection: " + (char) direction;
  return result;
}












}
