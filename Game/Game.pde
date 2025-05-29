//Game
Map map;
ArrayList<Ghost> ghostList;
Pacman pac;
int tileSize = 54;

void setup()
{
  size(1080,1566);
  //map = new Map(getMap(1));
  //for(int i = 0; i < 4; i++){ghostList.add(new Ghost(map));}
  //System.out.println(map);
  pac = new Pacman(new MapNode(new int[]{100,100},0),"left");
  
  
}


void draw()
{
  fill(200);
  rect(0,0,1080,1566);
  fill(250, 239, 25);
  circle(pac.locationInt[0],pac.locationInt[1],100);
  pac.move();
}


void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      pac.changeDirection("up");
    }
    else if (keyCode == DOWN) {
      pac.changeDirection("down");
    }
    else if (keyCode == LEFT) {
      pac.changeDirection("left");
    }
    else if (keyCode == RIGHT) {
      pac.changeDirection("right");
    }
  }
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
