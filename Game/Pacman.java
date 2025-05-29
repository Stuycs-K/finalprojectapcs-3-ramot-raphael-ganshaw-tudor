public class Pacman {
    private MapNode location;
    public int[] locationInt;
    private String direction;
    private boolean poweredUp;

    public Pacman(MapNode loc, String dir) {
        location = loc;
        direction = dir;
        poweredUp = false;
        locationInt = loc.getLocation();
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
    
    public int[] getLocationInt() {
      return locationInt;
    }
    
    public void move() {
      if (direction.equals("up")) {
        locationInt[1]--;
      }
      else if (direction.equals("down")) {
        locationInt[1]++;
      }
      else if (direction.equals("left")) {
         locationInt[0]--;
      }
      else if (direction.equals("right")) {
        locationInt[0]++;
      }
    }
}
