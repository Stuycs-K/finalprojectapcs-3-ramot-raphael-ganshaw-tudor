//Game
Map map;
ArrayList<Ghost> ghostList;
Pacman PacMan;
int tileSize = 54;

void setup()
{
  size(1080,1566);
  map = new Map(getMap(1));
  for(int i = 0; i < 4; i++){ghostList.add(new Ghost(map));}
  System.out.println(map);
  
  
  
}


void draw()
{
  
  
  
}



public int[][] getMap(int mapNum) //dont worry about how this works, just know it does
{
  int[][] result = new int[1][1];
  
  String[] lines = loadStrings("Map" + mapNum + ".txt");
  char[] lines2 = new char[lines.length];
  int[][] arr2 = new int[lines.length][lines[0].length()];
  for(int i = 0; i < lines.length; i++)
  {
   lines2 = lines[i].toCharArray(); 
   for(int n = 0; n < arr2[i].length; n++)
   {
     arr2[i][n] = lines2[n];
   }
  }
  


  return arr2;
}
