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
  while(location != null && location.getObject() != 5)
  {
    location = map1.getAt((int) (Math.random() * mapDimensions[0]),(int) (Math.random() * mapDimensions[1]));
  }
  type = 1;
  isAfraid = false;
  direction = directionList[(int) (Math.random() * 4)];

}


public void move()
{
  if(direction == UP)
  {
    location[0]--;
    if(!map.isOnScreen(location))
    {
      direction = DOWN;
      move();
    }
  }
  if(direction == DOWN)
  {
    location[0]++;
    if(!map.isOnScreen(location))
    {
      direction = UP;
      move();
    }
  }
  if(direction == LEFT)
  {
    location[1]--;
    if(!map.isOnScreen(location))
    {
      direction = RIGHT;
      move();
    }
  }
  if(direction == RIGHT)
  {
    location[1]++;
    if(!map.isOnScreen(location))
    {
      direction = LEFT;
      move();
    }
  }
}


public int[] getLocation()
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
  result += "Location: (" + location[0] + ", " + location[1] + ")\nType: " + type + "\nisAfraid: " + isAfraid + "\nDirection: " + (char) direction;
  return result;
}












}
