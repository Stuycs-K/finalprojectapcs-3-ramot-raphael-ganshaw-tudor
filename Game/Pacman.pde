public class Pacman {
    private MapNode location;
    private String direction;
    private boolean poweredUp;

    public Pacman(MapNode loc, String dir) {
        location = loc;
        direction = dir;
        poweredUp = false;
    }

    public void changeLocation(MapNode loc) {
        location = loc;
    }
    public MapNode getLocation() {
        return location;
    }

    public void changeDirection(String dir) {
        direction = dir;
    }
    public String getDirection() {
        return direction;
    }

    public void powerUp(boolean pow) {
        poweredUp = pow;
    }
    public boolean isPoweredUp() {
        return poweredUp;
    }
    
    public void move() {
      if (direction.equals("up") && location.getUp()!=null) {
         moveSlowly();
      }
      else if (direction.equals("down") && location.getDown()!=null) {
        moveSlowly();
      }
      else if (direction.equals("left") && location.getLeft()!=null) {
        moveSlowly();
      }
      else if (direction.equals("right") && location.getRight()!=null) {
        moveSlowly();
      }
    }
    public void moveSlowly() {
      
    }
}
