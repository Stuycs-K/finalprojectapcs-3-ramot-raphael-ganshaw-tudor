public class Pacman {
    private MapNode location;
    private int direction;
    private boolean poweredUp;

    public Pacman(MapNode loc, int dir) {
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

    public void changeDirection(int dir) {
        direction = dir;
    }
    public int getDirection() {
        return direction;
    }

    public void powerUp(boolean pow) {
        poweredUp = pow;
    }
    public boolean isPoweredUp() {
        return poweredUp;
    }
}
