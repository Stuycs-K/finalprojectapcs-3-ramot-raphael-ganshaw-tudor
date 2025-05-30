public class Pacman {
    private MapNode node;
    public int[] location;
    private String direction;
    private String newDirection;
    private boolean poweredUp;
    private int score;

    public Pacman(MapNode loc, String dir) {
        node = loc;
        direction = dir;
        poweredUp = false;
        location = loc.getLocation();
        newDirection = dir;
    }

    public void setNode(MapNode loc) {
        node = loc;
    }
    public MapNode getNode() {
        return node;
    }

    public void setDirection(String dir) {
        newDirection = dir;
    }
    public String getDirection() {
        return direction;
    }
    public void changeDirection() {
      if (node.getObject()==1)
        score++;
      else if (node.getObject()==2)
        powerUp(true);
      node.setObject(0);
      // here we can keep score
      
      if (newDirection.equals("up") && node.getUp()!=null) {
        direction = newDirection;
      }
      else if (newDirection.equals("down") && node.getDown()!=null) {
        direction = newDirection;
      }
      else if (newDirection.equals("left") && node.getLeft()!=null) {
        direction = newDirection;
      }
      else if (newDirection.equals("right") && node.getRight()!=null) {
        direction = newDirection;
      }
      
      if (direction.equals("up") && node.getUp()!=null) {
        node = node.getUp();
      }
      else if (direction.equals("down") && node.getDown()!=null) {
        node = node.getDown();
      }
      else if (direction.equals("left") && node.getLeft()!=null) {
        node = node.getLeft();
      }
      else if (direction.equals("right") && node.getRight()!=null) {
        node = node.getRight();
      }
      else
        direction = "none"; //won't move if going into a wall
    }

    public void powerUp(boolean pow) {
        poweredUp = pow;
    }
    public boolean isPoweredUp() {
        return poweredUp;
    }
    
    public int[] getLocation() {
      return location;
    }
    
    public void move() {
      if (direction.equals("up")) {
        location[1]-=2;
      }
      else if (direction.equals("down")) {
        location[1]+=2;
      }
      else if (direction.equals("left")) {
         location[0]-=2;
      }
      else if (direction.equals("right")) {
        location[0]+=2;
      }
    }
    
    public int getScore() {
      return score;
    }
    public void changeScore(int added) {
      score+=added;
    }
}
