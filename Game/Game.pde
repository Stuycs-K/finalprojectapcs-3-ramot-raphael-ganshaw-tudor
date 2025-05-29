//Game
Map map;
ArrayList<Ghost> ghostList;
Pacman pac;
int tileSize = 54;

void setup()
{
  size(1080,1566);
  map = new Map(getMap(1));
  //for(int i = 0; i < 4; i++){ghostList.add(new Ghost(map));}
  //System.out.println(map);
  pac = new Pacman(new MapNode(new int[]{100,100},0),"left");
  
  
}


void draw()
{
  fill(200);
  rect(0,0,1080,1566);
  drawTiles();
  fill(250, 239, 25);
  circle(pac.getLocation()[0],pac.getLocation()[1],tileSize-10);
  if (pac.getLocation()[0]==pac.getNode().getLocation()[0] && pac.getLocation()[1]==pac.getNode().getLocation()[1]) {
    pac.changeDirection();
  }
  pac.move();
}


void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      pac.setDirection("up");
    }
    else if (keyCode == DOWN) {
      pac.setDirection("down");
    }
    else if (keyCode == LEFT) {
      pac.setDirection("left");
    }
    else if (keyCode == RIGHT) {
      pac.setDirection("right");
    }
  }
}


public int[][] getMap(int mapNum)
{
  String[] lines = loadStrings("Map" + mapNum + ".txt");
  char[][] lines2 = new char[lines.length][lines[0].length()];
  for (int i = 0; i<lines.length; i++) {
    lines2[i] = lines[i].toCharArray();
  }
  int[][] arr = new int[lines.length][lines[0].length()];
  for(int i = 0; i < arr.length; i++)
  {
   for(int n = 0; n < arr[i].length; n++)
   {
     arr[i][n] = Character.getNumericValue(lines2[i][n]);
   }
  }
  return arr;
}
public void drawTiles() {
  for (int i = 0; i<map.mapDimensions()[1]; i++) {
    for (int n = 0; n<map.mapDimensions()[0]; n++) {
      square(i*tileSize,n*tileSize,tileSize);
    }
  }
}
