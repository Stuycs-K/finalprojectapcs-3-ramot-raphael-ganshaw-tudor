import java.util.*;
import java.io.*;

public class Map{

private int[][] mapArr;
private MapNode[][] tiles;


public Map(int[][] map)
{
   mapArr = map; 
   tiles = new MapNode[mapArr.length][mapArr[0].length];
   toNodeMap();
}



public void toNodeMap()
{
  for(int i = 0; i < mapArr.length;i++)
  {
    for(int n = 0; n < mapArr[i].length; n++)
    {
      tiles[i][n] = new MapNode(new int[]{n*Game.tileSize+(Game.tileSize/2),i*Game.tileSize+(Game.tileSize/2)}, mapArr[i][n]);
    }
  }

  for(int i = 0; i < mapArr.length;i++)
  {
    for(int n = 0; n < mapArr[i].length; n++)
    {
      if(isOnScreen(i-1,n) && mapArr[i-1][n] != 6){tiles[i][n].setUp(tiles[i-1][n]);}
      if(isOnScreen(i+1,n) && mapArr[i+1][n] != 6){tiles[i][n].setDown(tiles[i+1][n]);}
      if(isOnScreen(i,n-1) && mapArr[i][n-1] != 6){tiles[i][n].setLeft(tiles[i][n-1]);}
      if(isOnScreen(i,n+1) && mapArr[i][n+1] != 6){tiles[i][n].setRight(tiles[i][n+1]);}
      if(n == 0){tiles[i][n].setLeft(tiles[i][mapArr[i].length-1]);}
      if(n == mapArr[i].length-1){tiles[i][n].setRight(tiles[i][0]);}
    }
  }

}




public int[] mapDimensions()
{
  return new int[] {mapArr.length,mapArr[0].length};
}

public MapNode getAt(int y, int x)
{
  return tiles[y][x];
}

public MapNode getAt(int[] location)
{
  return getAt(location[0],location[1]);
}

public void setAt(int y, int x, int n)
{
  mapArr[y][x] = n;
}

public void setAt(int[] location, int n)
{
setAt(location[0],location[1],n);
}

public boolean isOnScreen(int y, int x)
{
  return (y > -1 && y < mapArr.length) && (x > -1 && x < mapArr[0].length);
}

public boolean isOnScreen(int[] location)
{
  return isOnScreen(location[0],location[1]);
}

public boolean isOnScreen(MapNode loc)
{
  return isOnScreen(loc.getLocation());
}


public String toString(){
  String answer = "";
  for(int i = 0; i < mapArr.length;i++)
  {
    for(int n = 0; n < mapArr[i].length;n++)
    {
      answer += mapArr[i][n];
      if(n == mapArr[i].length-1){answer+="\n";}
    }
  }

  return answer;
}

}
