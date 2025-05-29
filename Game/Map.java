import java.util.*;
import java.io.*;

public class Map{

private int[][] mapArr;
private int numPellets;
private int[] startCoords;
private MapNode[][] tiles;


public Map(int[][] map)
{
   mapArr = map; 
   tiles = new MapNode[mapArr.length][mapArr[0].length];
   toNodeMap();
}

/*
public Map(int mapNumber)
{
  mapArr = Game.getMap(mapNumber);
  tiles = new MapNode[mapArr.length][mapArr[0].length];
  toNodeMap(); //getMap will take a text file and turn it into an array. The text files will be named Map1, Map2, etc. This could be changed if we generate maps randomly
//  createPellets(); // puts pellets on the map in empty spaces
}
*/




public void toNodeMap()
{
  for(int i = 0; i < mapArr.length;i++)
  {
    for(int n = 0; n < mapArr[i].length; n++)
    {
      tiles[i][n] = new MapNode(new int[]{i*Game.tileSize+(Game.tileSize/2),n*Game.tileSize+(Game.tileSize/2)}, mapArr[i][n]);
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
    }
  }

}



/*public void createPellets()
{
  for(int i = 0; i < mapArr.length; i++)
    {
      for(int n = 0; n < mapArr[i].length; n++)
        {
          if(mapArr[i][n] == 0) //if coordinate is empty space
            {
              mapArr[i][n] = 1; //set to a pellet
              numPellets++; //increase pellet count
            }
        }
    }
}*/

public int getStartX()
{
  return startCoords[0];
}

public int getStartY()
{
  return startCoords[1];
}

public int getPellets()
{
  return numPellets;
}

public void setPellets(int p)
{
  numPellets = p;
}

public void removePellet()
{
  numPellets--;
}

public void genItems()
{
  //generate 2-3 items in places with pellets
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
