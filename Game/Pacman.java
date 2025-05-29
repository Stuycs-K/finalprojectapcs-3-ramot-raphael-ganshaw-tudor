public class Pacman {
    private MapNode node;
    public int[] location;
    private String direction;
    private String newDirection;
    private boolean poweredUp;

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
      node.setObject(0);
      // here we can keep score
      
      if (newDirection.equals("up") && node.getUp()!=null) {
        direction = newDirection;
        node = node.getUp();
      }
      else if (newDirection.equals("down") && node.getDown()!=null) {
        direction = newDirection;
        node = node.getDown();
      }
      else if (newDirection.equals("left") && node.getLeft()!=null) {
        direction = newDirection;
        node = node.getLeft();
      }
      else if (newDirection.equals("right") && node.getRight()!=null) {
        direction = newDirection;
        node = node.getRight();
      }
      else
        direction = "none";
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
        location[1]--;
      }
      else if (direction.equals("down")) {
        location[1]++;
      }
      else if (direction.equals("left")) {
         location[0]--;
      }
      else if (direction.equals("right")) {
        location[0]++;
      }
    }
}
